package com.ces.androidappkit.app

import android.app.Application
import androidx.lifecycle.DefaultLifecycleObserver
import androidx.lifecycle.LifecycleOwner
import androidx.lifecycle.ProcessLifecycleOwner
import com.ces.androidappkit.logger.application_lifecycle_events.DefaultLifecycleObserverHelper
import com.ces.androidappkit.logger.application_lifecycle_events.LifeCycleEventObserverHelper
import com.ces.androidframework.log_helper.LogUtils
import dagger.hilt.android.HiltAndroidApp

private const val TAG = "AppKitApplication"

@HiltAndroidApp
class AppKitApplication : Application() {

    override fun onCreate() {
        super.onCreate()
        ProcessLifecycleOwner.get().lifecycle.addObserver(defaultLifecycleObserver)
        ProcessLifecycleOwner.get().lifecycle.addObserver(LifeCycleEventObserverHelper())
        DefaultLifecycleObserverHelper(ProcessLifecycleOwner.get())
    }

    private var defaultLifecycleObserver = object : DefaultLifecycleObserver {

        override fun onStart(owner: LifecycleOwner) {
            super.onStart(owner)
            //your code here
            LogUtils.debug(TAG, "defaultLifecycleObserver in app onStart")
        }

        override fun onStop(owner: LifecycleOwner) {
            super.onStop(owner)
            //your code here
            LogUtils.debug(TAG, "defaultLifecycleObserver in app onStop")
        }

        override fun onDestroy(owner: LifecycleOwner) {
            super.onDestroy(owner)
            LogUtils.debug(TAG, "defaultLifecycleObserver in app onDestroy")
        }
    }


}