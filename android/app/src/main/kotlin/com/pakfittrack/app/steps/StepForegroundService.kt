package com.pakfittrack.app.steps

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import android.os.Build
import android.os.IBinder
import androidx.core.app.NotificationCompat
import com.pakfittrack.app.R
import io.flutter.plugin.common.EventChannel
import com.pakfittrack.app.steps.db.DailyStepsEntity
import com.pakfittrack.app.steps.db.StepsDatabase
import java.util.concurrent.Executors

class StepForegroundService : Service(), SensorEventListener {
  private lateinit var sensorManager: SensorManager
  private var stepCounter: Sensor? = null

  private lateinit var prefs: StepPrefs
  private var dateReceiverRegistered = false
  private lateinit var db: StepsDatabase
  private val dbExecutor = Executors.newSingleThreadExecutor()

  private var lastEmittedSteps: Long = -1L

  override fun onCreate() {
    super.onCreate()
    prefs = StepPrefs(applicationContext)
    db = StepsDatabase.get(applicationContext)
    sensorManager = getSystemService(Context.SENSOR_SERVICE) as SensorManager
    stepCounter = sensorManager.getDefaultSensor(Sensor.TYPE_STEP_COUNTER)

    startForeground(NOTIF_ID, buildNotification(prefs.getLastComputedToday()))

    // Register sensor listener (fast enough for UI, low power)
    stepCounter?.let {
      sensorManager.registerListener(this, it, SensorManager.SENSOR_DELAY_NORMAL)
    }

    // Deterministic daily rollover without polling:
    // use system broadcasts for date/time changes.
    registerDateChangeReceiver()
  }

  override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
    // Keep running until explicitly stopped by OS/user
    return START_STICKY
  }

  override fun onDestroy() {
    unregisterDateChangeReceiver()
    sensorManager.unregisterListener(this)
    super.onDestroy()
  }

  override fun onBind(intent: Intent?): IBinder? = null

  override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {}

  override fun onSensorChanged(event: SensorEvent?) {
    val e = event ?: return
    if (e.sensor.type != Sensor.TYPE_STEP_COUNTER) return
    val sensorValue = e.values.firstOrNull()?.toLong() ?: return
    handleSensorValue(sensorValue)
  }

  private fun handleSensorValue(sensorValue: Long) {
    val todayIso = StepPrefs.todayIso()
    val state = StepComputation.computeFromCumulativeSensor(sensorValue, prefs, todayIso)

    // If day rollover detected, finalize yesterday deterministically using the last computed value,
    // then reset baseline for the new day.
    if (state.dayRolloverDetected) {
      finalizePreviousDayAndReset(sensorValue, state.activeDateIso, todayIso)
    }

    persistStateAndEmit(state.copy(activeDateIso = todayIso), todayIso)
  }

  private fun finalizePreviousDayAndReset(sensorValue: Long, prevDateIso: String, todayIso: String) {
    val lastToday = prefs.getLastComputedToday()
    prefs.setFinalizedFor(prevDateIso, lastToday)
    persistDailyMax(prevDateIso, lastToday)

    // Reset for today: baseline to current cumulative sensor, carry=0, activeDate=today
    prefs.setCarrySteps(0L)
    prefs.setBaselineSensorValue(sensorValue)
    prefs.setActiveDate(todayIso)
  }

  private fun persistStateAndEmit(state: StepState, todayIso: String) {
    prefs.setLastSensorValue(state.lastSensor)
    prefs.setBaselineSensorValue(state.baselineSensor)
    prefs.setCarrySteps(state.carrySteps)
    prefs.setActiveDate(todayIso)
    prefs.setLastComputedToday(state.todaySteps)

    // Native authoritative persistence (Room): max-only upsert.
    persistDailyMax(todayIso, state.todaySteps)

    if (state.todaySteps != lastEmittedSteps) {
      lastEmittedSteps = state.todaySteps
      Events.emit(state.todaySteps.toInt())
      updateNotification(state.todaySteps)
    }
  }

  private fun persistDailyMax(dateIso: String, steps: Long) {
    val now = System.currentTimeMillis()
    dbExecutor.execute {
      try {
        val dao = db.dailyStepsDao()
        val existing = dao.getForDate(dateIso)
        val nextSteps = if (existing == null) steps else maxOf(existing.steps, steps)
        if (existing == null || nextSteps != existing.steps) {
          dao.upsert(DailyStepsEntity(dateIso = dateIso, steps = nextSteps, updatedAtEpochMs = now))
        }
      } catch (_: Exception) {}
    }
  }

  private fun updateNotification(steps: Long) {
    val nm = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
    nm.notify(NOTIF_ID, buildNotification(steps))
  }

  private val dateChangeReceiver = object : BroadcastReceiver() {
    override fun onReceive(context: Context?, intent: Intent?) {
      try {
        val todayIso = StepPrefs.todayIso()
        val active = prefs.getActiveDate()
        if (active != null && active != todayIso) {
          // Use last sensor value if available; otherwise keep last computed as yesterday final.
          val lastSensor = prefs.getLastSensorValue().coerceAtLeast(0L)
          finalizePreviousDayAndReset(lastSensor, active, todayIso)
          prefs.setLastComputedToday(0L)
          persistDailyMax(todayIso, 0L)
          // Emit updated (reset) today state to Flutter (0 steps) to avoid stale UI.
          Events.emit(0)
        }
        updateNotification(prefs.getLastComputedToday())
      } catch (_: Exception) {}
    }
  }

  private fun registerDateChangeReceiver() {
    if (dateReceiverRegistered) return
    dateReceiverRegistered = true
    val filter = IntentFilter().apply {
      addAction(Intent.ACTION_DATE_CHANGED)
      addAction(Intent.ACTION_TIME_CHANGED)
      addAction(Intent.ACTION_TIMEZONE_CHANGED)
    }
    registerReceiver(dateChangeReceiver, filter)
  }

  private fun unregisterDateChangeReceiver() {
    if (!dateReceiverRegistered) return
    dateReceiverRegistered = false
    try {
      unregisterReceiver(dateChangeReceiver)
    } catch (_: Exception) {}
  }

  private fun buildNotification(steps: Long): Notification {
    ensureChannel()
    return NotificationCompat.Builder(this, CHANNEL_ID)
      .setContentTitle("Step tracking active")
      .setContentText("Today: $steps steps")
      .setSmallIcon(R.mipmap.ic_launcher)
      .setOngoing(true)
      .setOnlyAlertOnce(true)
      .setPriority(NotificationCompat.PRIORITY_LOW)
      .build()
  }

  private fun ensureChannel() {
    if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O) return
    val nm = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
    val existing = nm.getNotificationChannel(CHANNEL_ID)
    if (existing != null) return
    val ch = NotificationChannel(
      CHANNEL_ID,
      "Step tracking",
      NotificationManager.IMPORTANCE_LOW
    )
    ch.description = "Keeps step tracking running in background"
    nm.createNotificationChannel(ch)
  }

  companion object {
    private const val CHANNEL_ID = "pakfittrack_steps"
    private const val NOTIF_ID = 2001

    object Events {
      @Volatile private var sink: EventChannel.EventSink? = null

      fun streamHandler(context: Context): EventChannel.StreamHandler {
        return object : EventChannel.StreamHandler {
          override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
            sink = events
            // Immediately emit latest known value
            try {
              val prefs = StepPrefs(context)
              events?.success(prefs.getLastComputedToday().toInt())
            } catch (_: Exception) {}
          }

          override fun onCancel(arguments: Any?) {
            sink = null
          }
        }
      }

      fun emit(steps: Int) {
        sink?.success(steps)
      }
    }
  }
}

