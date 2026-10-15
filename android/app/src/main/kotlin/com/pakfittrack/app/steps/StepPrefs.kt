package com.pakfittrack.app.steps

import android.content.Context
import android.content.SharedPreferences
import java.time.LocalDate

internal class StepPrefs(context: Context) {
  private val prefs: SharedPreferences =
    context.getSharedPreferences("pakfittrack_steps", Context.MODE_PRIVATE)

  fun isEnabled(): Boolean = prefs.getBoolean("step_tracking_enabled", false)
  fun setEnabled(v: Boolean) = prefs.edit().putBoolean("step_tracking_enabled", v).apply()

  fun getLastSensorValue(): Long = prefs.getLong("last_sensor_value", -1L)
  fun setLastSensorValue(v: Long) = prefs.edit().putLong("last_sensor_value", v).apply()

  fun getBaselineSensorValue(): Long = prefs.getLong("baseline_sensor_value", -1L)
  fun setBaselineSensorValue(v: Long) = prefs.edit().putLong("baseline_sensor_value", v).apply()

  fun getCarrySteps(): Long = prefs.getLong("carry_steps", 0L)
  fun setCarrySteps(v: Long) = prefs.edit().putLong("carry_steps", v).apply()

  fun getActiveDate(): String? = prefs.getString("active_date", null)
  fun setActiveDate(dateIso: String) = prefs.edit().putString("active_date", dateIso).apply()

  fun getLastComputedToday(): Long = prefs.getLong("last_today_steps", 0L)
  fun setLastComputedToday(v: Long) = prefs.edit().putLong("last_today_steps", v).apply()

  fun getFinalizedFor(dateIso: String): Long? {
    val has = prefs.contains("daily_$dateIso")
    if (!has) return null
    return prefs.getLong("daily_$dateIso", 0L)
  }

  fun setFinalizedFor(dateIso: String, steps: Long) {
    prefs.edit().putLong("daily_$dateIso", steps).apply()
  }

  /**
   * Clears the entire "pakfittrack_steps" prefs file. Every key in this file
   * belongs to the step tracker (enable flag, sensor baselines, per-day
   * finalized counts), so a full clear is safe-scoped. Used by the
   * account-deletion local cleanup. StepComputation re-initialises its
   * baselines on the next start (baseline < 0 → baseline = sensorValue).
   */
  fun clear() {
    prefs.edit().clear().apply()
  }

  companion object {
    fun todayIso(): String = LocalDate.now().toString() // yyyy-MM-dd
  }
}

