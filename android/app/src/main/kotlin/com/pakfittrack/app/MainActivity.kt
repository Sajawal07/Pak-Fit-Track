package com.pakfittrack.app

import android.content.Intent
import android.os.Build
import com.pakfittrack.app.steps.StepForegroundService
import com.pakfittrack.app.steps.StepPrefs
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import com.pakfittrack.app.steps.BatteryChannel
import com.pakfittrack.app.steps.db.StepsDatabase

class MainActivity : FlutterActivity() {
  private val methodChannelName = "pakfittrack/steps"
  private val eventChannelName = "pakfittrack/steps_events"
  private val batteryChannelName = "pakfittrack/battery"
  private val stepsStoreChannelName = "pakfittrack/steps_store"

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
        try {
          val db = StepsDatabase.get(applicationContext)
          val dao = db.dailyStepsDao()
          when (call.method) {
            "getTodaySteps" -> {
              val today = com.pakfittrack.app.steps.StepPrefs.todayIso()
              val row = dao.getForDate(today)
              result.success((row?.steps ?: 0L).toInt())
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
              result.success(map)
            }
            else -> result.notImplemented()
          }
        } catch (e: Exception) {
          result.error("STEPS_STORE_ERROR", e.message, null)
        }
      }
  }
}
