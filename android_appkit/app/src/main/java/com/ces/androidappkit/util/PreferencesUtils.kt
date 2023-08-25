package com.ces.androidappkit.util

import android.content.Context
import androidx.datastore.preferences.core.*
import com.ces.androidappkit.data.datastore.dataStore
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.map


class PreferencesUtils(context: Context) {

    //Fetch the dataStore
    private val dataStore = context.dataStore

    //Create keys and use them to store and retrieve the data
    companion object {

        //User Details
        val PREF_IS_FIRST_TIME = booleanPreferencesKey("IS_FIRST_TIME")
        val PREF_USER_ID = stringPreferencesKey("USER_ID")

    }

    suspend fun setIsFirstTime(value: Boolean) {
        dataStore.edit {
            it[PREF_IS_FIRST_TIME] = value
        }
    }

    val isFirstTime: Flow<Boolean> = dataStore.data.map {
        it[PREF_IS_FIRST_TIME] ?: true
    }

    suspend fun setLoggedInUserId(value: String) {
        dataStore.edit {
            it[PREF_USER_ID] = value
        }
    }

    val getLoggedInUserId: Flow<String> = dataStore.data.map {
        it[PREF_USER_ID] ?: ""
    }

    //    Use to clear the data all at once
    suspend fun clearDataStore() {
        dataStore.edit {
            it.clear()
        }
    }


}