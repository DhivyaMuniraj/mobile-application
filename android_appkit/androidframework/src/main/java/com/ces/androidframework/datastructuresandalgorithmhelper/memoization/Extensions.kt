package com.ces.androidframework.datastructuresandalgorithmhelper.memoization

fun <T, R> ((T) -> R).memoize(): (T) -> R = Memoize(this)
