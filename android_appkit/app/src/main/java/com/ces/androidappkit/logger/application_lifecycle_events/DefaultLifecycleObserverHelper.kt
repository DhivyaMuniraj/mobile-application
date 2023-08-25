package com.ces.androidappkit.logger.application_lifecycle_events

import androidx.lifecycle.DefaultLifecycleObserver
import androidx.lifecycle.LifecycleOwner
import com.ces.androidframework.log_helper.LogUtils

private const val TAG = "MasterCraft"

class DefaultLifecycleObserverHelper(lifecycleOwner: LifecycleOwner) : DefaultLifecycleObserver {

    init {
        lifecycleOwner.lifecycle.addObserver(this)
    }

    override fun onStart(owner: LifecycleOwner) {
        super.onStart(owner)
        LogUtils.debug(TAG, "defaultLifecycleObserver onStart")
    }

    override fun onDestroy(owner: LifecycleOwner) {
        super.onDestroy(owner)
        LogUtils.debug(TAG, "defaultLifecycleObserver onDestroy")
    }

    override fun onResume(owner: LifecycleOwner) {
        super.onResume(owner)
        LogUtils.debug(TAG, "defaultLifecycleObserver onResume")
    }

    override fun onPause(owner: LifecycleOwner) {
        super.onPause(owner)
        LogUtils.debug(TAG, "defaultLifecycleObserver onPause")
    }

    override fun onStop(owner: LifecycleOwner) {
        super.onStop(owner)
        LogUtils.debug(TAG, "defaultLifecycleObserver onStop")
    }
}