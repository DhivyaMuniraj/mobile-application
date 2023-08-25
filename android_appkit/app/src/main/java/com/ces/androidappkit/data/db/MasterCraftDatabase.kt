package com.ces.androidappkit.data.db

import androidx.room.Database
import androidx.room.RoomDatabase
import com.ces.androidappkit.BuildConfig
import com.ces.androidappkit.data.db.dao.UserDao
import com.ces.androidappkit.data.db.entity.User


@Database(
    entities = [User::class],
    version = 1,
    exportSchema = false
)
abstract class AppDatabase : RoomDatabase() {

    companion object {
        private val applicationId = BuildConfig.APPLICATION_ID.replace(".", "_")
        private val dbName = "${applicationId}_db"
        val DATABASE_NAME = dbName
    }

    abstract val userDao: UserDao

}