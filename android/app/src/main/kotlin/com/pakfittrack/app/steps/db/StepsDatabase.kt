package com.pakfittrack.app.steps.db

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase

@Database(
  entities = [DailyStepsEntity::class],
  version = 1,
  exportSchema = false,
)
abstract class StepsDatabase : RoomDatabase() {
  abstract fun dailyStepsDao(): DailyStepsDao

  companion object {
    @Volatile private var instance: StepsDatabase? = null

    fun get(context: Context): StepsDatabase {
      val existing = instance
      if (existing != null) return existing
      return synchronized(this) {
        val again = instance
        if (again != null) return again
        val created = Room.databaseBuilder(
          context.applicationContext,
          StepsDatabase::class.java,
          "steps.db"
        ).build()
        instance = created
        created
      }
    }
  }
}

