package com.pakfittrack.app.steps.db

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query

@Dao
interface DailyStepsDao {
  @Query("SELECT * FROM daily_steps WHERE dateIso = :dateIso LIMIT 1")
  fun getForDate(dateIso: String): DailyStepsEntity?

  @Insert(onConflict = OnConflictStrategy.REPLACE)
  fun upsert(entity: DailyStepsEntity)

  @Query("SELECT * FROM daily_steps WHERE dateIso BETWEEN :startIso AND :endIso ORDER BY dateIso ASC")
  fun getRange(startIso: String, endIso: String): List<DailyStepsEntity>
}

