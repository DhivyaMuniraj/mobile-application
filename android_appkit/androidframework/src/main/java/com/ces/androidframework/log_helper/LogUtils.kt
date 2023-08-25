package com.ces.androidframework.log_helper

import android.util.Log
import com.ces.androidframework.BuildConfig

class LogUtils {

    companion object {
        fun debug(tag: String, message: Any?) = apply {
            if (BuildConfig.DEBUG) {
                Log.d(tag, message.toString())
            }
        }

        fun error(tag: String, message: Any?) = apply {
            if (BuildConfig.DEBUG) {
                Log.e(tag, message.toString())
            }
        }

        fun wtf(tag: String, message: Any?) = apply {
            if (BuildConfig.DEBUG) {
                Log.wtf(tag, message.toString())
            }
        }

        fun warning(tag: String, message: Any?) = apply {
            if (BuildConfig.DEBUG) {
                Log.w(tag, message.toString())
            }
        }

        fun info(tag: String, message: Any?) = apply {
            if (BuildConfig.DEBUG) {
                Log.i(tag, message.toString())
            }
        }

        fun verbose(tag: String, message: Any?) = apply {
            if (BuildConfig.DEBUG) {
                Log.v(tag, message.toString())
            }
        }
    }
}