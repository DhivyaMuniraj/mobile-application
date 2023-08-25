package com.ces.androidframework.viewhelper

import android.view.ScaleGestureDetector
import android.view.ScaleGestureDetector.SimpleOnScaleGestureListener
import android.view.View
import kotlin.math.max
import kotlin.math.min


class ScaleListener(private var mScaleFactor: Float, private val view: View) :
    SimpleOnScaleGestureListener() {

    override fun onScale(scaleGestureDetector: ScaleGestureDetector): Boolean {
        mScaleFactor *= scaleGestureDetector.scaleFactor
        mScaleFactor = max(0.1f, min(mScaleFactor, 10.0f))
        view.scaleX = mScaleFactor
        view.scaleY = mScaleFactor
        return true
    }
}