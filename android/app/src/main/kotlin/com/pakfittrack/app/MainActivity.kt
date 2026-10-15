package com.pakfittrack.app

import android.content.Intent
import android.os.Build
import com.pakfittrack.app.steps.BatteryChannel
import com.pakfittrack.app.steps.StepForegroundService
import com.pakfittrack.app.steps.StepPrefs
import com.pakfittrack.app.steps.db.StepsDatabase
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import java.util.concurrent.Executors
import kotlin.math.max

class MainActivity : FlutterActivity() {
  private val methodChannelName = "pakfittrack/steps"
  private val eventChannelName = "pakfittrack/steps_events"
  private val batteryChannelName = "pakfittrack/battery"
  private val stepsStoreChannelName = "pakfittrack/steps_store"
  private val stepsStoreExecutor = Executors.newSingleThreadExecutor()

  override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)

    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, methodChannelName)
      .setMethodCallHandler { call, result ->
        when (call.method) {
          "start" -> {
            try {
              val i = Intent(this, StepForegroundService::class.java)
              if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                startForegroundService(i)
              } else {
                startService(i)
              }
              result.success(true)
            } catch (e: Exception) {
              result.error("START_FAILED", e.message, null)
            }
          }
          "setEnabled" -> {
            try {
              val args = call.arguments as? Map<*, *> ?: emptyMap<Any, Any>()
              val enabled = (args["enabled"] as? Boolean) ?: false
              StepPrefs(applicationContext).setEnabled(enabled)
              result.success(true)
            } catch (e: Exception) {
              result.error("SET_ENABLED_FAILED", e.message, null)
            }
          }
          "stop" -> {
            try {
              val i = Intent(this, StepForegroundService::class.java)
              stopService(i)
              result.success(true)
            } catch (e: Exception) {
              result.error("STOP_FAILED", e.message, null)
            }
          }
          else -> result.notImplemented()
        }
      }

    EventChannel(flutterEngine.dartExecutor.binaryMessenger, eventChannelName)
      .setStreamHandler(StepForegroundService.Companion.Events.streamHandler(applicationContext))

    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, batteryChannelName)
      .setMethodCallHandler(BatteryChannel.handler(this))

    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, stepsStoreChannelName)
      .setMethodCallHandler { call, result ->
        // Room cannot run on the UI thread — queries must be off-main.
        stepsStoreExecutor.execute {
          try {
            val db = StepsDatabase.get(applicationContext)
            val dao = db.dailyStepsDao()
            val prefs = StepPrefs(applicationContext)
            when (call.method) {
              "getTodaySteps" -> {
                val today = StepPrefs.todayIso()
                val fromDb = dao.getForDate(today)?.steps ?: 0L
                // Prefs mirror live sensor math; use max so report never
                // under-reports when Room write is still in flight.
                val fromPrefs = prefs.getLastComputedToday()
                val steps = max(fromDb, fromPrefs)
                runOnUiThread { result.success(steps.toInt()) }
              }
              "getStepsRange" -> {
                val args = call.arguments as? Map<*, *> ?: emptyMap<Any, Any>()
                val start = (args["start"] as? String) ?: ""
                val end = (args["end"] as? String) ?: ""
                val rows = dao.getRange(start, end)
                val map = HashMap<String, Int>()
                for (r in rows) {
                  map[r.dateIso] = r.steps.toInt()
                }
                // Fill today from prefs if DB row is missing/stale.
                val today = StepPrefs.todayIso()
                if (start.isEmpty() || end.isEmpty() || (today >= start && today <= end)) {
                  val prefsToday = prefs.getLastComputedToday().toInt()
                  val existing = map[today] ?: 0
                  if (prefsToday > existing) map[today] = prefsToday
                }
                runOnUiThread { result.success(map) }
              }
              // Account-deletion local cleanup: wipe step history (Room) and
              // the step-tracker prefs file. Only the "pakfittrack_steps"
              // prefs file and the "daily_steps" table live behind this
              // channel, so a full clear here cannot touch other app data.
              "clearAllData" -> {
                dao.deleteAll()
                prefs.clear()
                runOnUiThread { result.success(true) }
              }
              else -> runOnUiThread { result.notImplemented() }
            }
          } catch (e: Exception) {
            runOnUiThread {
              // Last-resort: prefs-only so daily report still has steps.
              try {
                if (call.method == "getTodaySteps") {
                  val fromPrefs =
                    StepPrefs(applicationContext).getLastComputedToday().toInt()
                  result.success(fromPrefs)
                } else {
                  result.error("STEPS_STORE_ERROR", e.message, null)
                }
              } catch (_: Exception) {
                result.error("STEPS_STORE_ERROR", e.message, null)
              }
            }
          }
        }
      }
  }
}
