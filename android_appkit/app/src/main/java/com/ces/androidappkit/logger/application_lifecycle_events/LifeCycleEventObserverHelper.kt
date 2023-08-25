package com.ces.androidappkit.logger.application_lifecycle_events

import androidx.lifecycle.Lifecycle
import androidx.lifecycle.LifecycleEventObserver
import androidx.lifecycle.LifecycleOwner
import com.ces.androidframework.log_helper.LogUtils

internal class LifeCycleEventObserverHelper : LifecycleEventObserver {
    override fun onStateChanged(source: LifecycleOwner, event: Lifecycle.Event) {
        when (event) {
            Lifecycle.Event.ON_CREATE -> {
                LogUtils.debug("LifeCycleEvent", "on create")
            }
            Lifecycle.Event.ON_START -> {
                LogUtils.debug("LifeCycleEvent", "on start")
            }
            Lifecycle.Event.ON_RESUME -> {
                LogUtils.debug("LifeCycleEvent", "on resume")
            }
            Lifecycle.Event.ON_PAUSE -> {
                LogUtils.debug("LifeCycleEvent", "on pause")
            }
            Lifecycle.Event.ON_STOP -> {
                LogUtils.debug("LifeCycleEvent", "on stop")
            }
            Lifecycle.Event.ON_DESTROY -> {
                LogUtils.debug("LifeCycleEvent", "on destroy")
            }
            Lifecycle.Event.ON_ANY -> {
                LogUtils.debug("LifeCycleEvent", "on any")
            }
        }
    }
}