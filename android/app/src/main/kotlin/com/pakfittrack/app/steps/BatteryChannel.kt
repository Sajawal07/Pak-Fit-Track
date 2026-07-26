package com.pakfittrack.app.steps

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.PowerManager
import android.provider.Settings
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

object BatteryChannel {
  fun handler(activity: Activity): MethodChannel.MethodCallHandler {
    return MethodChannel.MethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
      when (call.method) {
        "isIgnoring" -> {
          try {
            val pm = activity.getSystemService(Context.POWER_SERVICE) as PowerManager
            val ignoring = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
              pm.isIgnoringBatteryOptimizations(activity.packageName)
            } else {
              true
            }
            result.success(ignoring)
          } catch (e: Exception) {
            result.error("BATTERY_CHECK_FAILED", e.message, null)
          }
        }
        "requestIgnore" -> {
          try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
              val intent = Intent(Settings.ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS).apply {
                data = Uri.parse("package:${activity.packageName}")
                addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
              }
              activity.startActivity(intent)
            }
            result.success(true)
          } catch (e: Exception) {
            result.error("BATTERY_REQUEST_FAILED", e.message, null)
          }
        }
        "openSettings" -> {
          try {
            val intent = Intent(Settings.ACTION_IGNORE_BATTERY_OPTIMIZATION_SETTINGS).apply {
              addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            }
            activity.startActivity(intent)
            result.success(true)
          } catch (e: Exception) {
            result.error("BATTERY_SETTINGS_FAILED", e.message, null)
          }
        }
        else -> result.notImplemented()
      }
    }
  }
}

