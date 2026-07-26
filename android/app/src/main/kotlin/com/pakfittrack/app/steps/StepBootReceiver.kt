package com.pakfittrack.app.steps

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Build

class StepBootReceiver : BroadcastReceiver() {
  override fun onReceive(context: Context, intent: Intent?) {
    val action = intent?.action ?: return
    if (action != Intent.ACTION_BOOT_COMPLETED && action != Intent.ACTION_MY_PACKAGE_REPLACED) return

    try {
      val prefs = StepPrefs(context)
      if (!prefs.isEnabled()) return
      val i = Intent(context, StepForegroundService::class.java)
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
        context.startForegroundService(i)
      } else {
        context.startService(i)
      }
    } catch (_: Exception) {
      // Best-effort only
    }
  }
}

