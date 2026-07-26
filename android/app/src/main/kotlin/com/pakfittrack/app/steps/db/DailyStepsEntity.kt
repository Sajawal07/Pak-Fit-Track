package com.pakfittrack.app.steps.db

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "daily_steps")
data class DailyStepsEntity(
  @PrimaryKey val dateIso: String, // yyyy-MM-dd (device local date)
  val steps: Long,
  val updatedAtEpochMs: Long,
)

