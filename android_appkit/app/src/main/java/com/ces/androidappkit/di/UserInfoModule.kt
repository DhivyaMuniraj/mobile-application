package com.ces.androidappkit.di

import com.ces.androidappkit.data.db.AppDatabase
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.components.ViewModelComponent
import dagger.hilt.android.scopes.ViewModelScoped


//Provides User Dao And also for all the other requirements for the User data, like repository use cases etc
@Module
@InstallIn(ViewModelComponent::class)
object UserInfoModule {

    @Provides
    @ViewModelScoped
    fun providesUserDao(
        db: AppDatabase,
    ) = db.userDao

}