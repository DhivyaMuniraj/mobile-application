package com.ces.androidappkit.data.datastore

import android.content.Context
import androidx.datastore.preferences.preferencesDataStore
import com.ces.androidappkit.BuildConfig
import dagger.hilt.android.qualifiers.ApplicationContext
import javax.inject.Inject
import javax.inject.Singleton

val applicationId = BuildConfig.APPLICATION_ID.replace(".", "_")
val preferenceName = "${applicationId}_preferences"
val Context.dataStore by preferencesDataStore(preferenceName)

@Singleton //You can ignore this annotation as return `datastore` from `preferencesDataStore` is singleton
class PreferencesManager @Inject constructor(@ApplicationContext appContext: Context) {
    private val settingsDataStore = appContext.dataStore
}