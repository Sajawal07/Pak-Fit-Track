package com.pakfittrack.app.steps

internal data class StepState(
  val todaySteps: Long,
  val activeDateIso: String,
  val baselineSensor: Long,
  val carrySteps: Long,
  val lastSensor: Long,
  val sensorResetDetected: Boolean,
  val dayRolloverDetected: Boolean,
)

internal object StepComputation {
  fun computeFromCumulativeSensor(
    sensorValue: Long,
    prefs: StepPrefs,
    nowDateIso: String,
  ): StepState {
    var lastSensor = prefs.getLastSensorValue()
    var baseline = prefs.getBaselineSensorValue()
    var carry = prefs.getCarrySteps()
    val activeDate = prefs.getActiveDate()

    var sensorReset = false
    var dayRollover = false

    if (baseline < 0) baseline = sensorValue
    if (lastSensor >= 0 && sensorValue < lastSensor) {
      // Sensor reset (commonly device reboot) - preserve continuity by converting
      // the already-computed steps into carry, then resetting baseline.
      sensorReset = true
      val lastToday = prefs.getLastComputedToday()
      carry = lastToday
      baseline = sensorValue
    }

    if (activeDate == null) {
      prefs.setActiveDate(nowDateIso)
    } else if (activeDate != nowDateIso) {
      dayRollover = true
    }

    val computed = carry + (sensorValue - baseline).coerceAtLeast(0)
    val todaySteps = computed.coerceIn(0, 999999)

    lastSensor = sensorValue
    return StepState(
      todaySteps = todaySteps,
      activeDateIso = activeDate ?: nowDateIso,
      baselineSensor = baseline,
      carrySteps = carry,
      lastSensor = lastSensor,
      sensorResetDetected = sensorReset,
      dayRolloverDetected = dayRollover,
    )
  }
}

