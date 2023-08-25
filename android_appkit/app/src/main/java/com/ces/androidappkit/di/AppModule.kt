package com.ces.androidappkit.di

import android.app.Application
import androidx.room.Room
import com.ces.androidappkit.data.db.AppDatabase
import com.google.gson.Gson
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
object AppModule {

    // The instance of the Room Database to be used in application context
    @Provides
    @Singleton
    fun provideRoomDatabase(app: Application): AppDatabase {
        return Room.databaseBuilder(
            app,
            AppDatabase::class.java,
            AppDatabase.DATABASE_NAME
        ).build()
    }

    // The Gson instance to be used in application context
    @Singleton
    @Provides
    fun provideGsonInstance(): Gson {
        return Gson()
    }

}