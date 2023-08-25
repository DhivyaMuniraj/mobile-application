package com.ces.androidappkit.extensions.validation_helper

import android.util.Patterns
import java.util.regex.Pattern

const val passwordPattern = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,16}$"
val passwordMatcher: Pattern = Pattern.compile(passwordPattern)

fun String.validateEmail(): Boolean {
    return Patterns.EMAIL_ADDRESS.matcher(this).matches()
}

fun String.match(s: String): Boolean {
    return this == s
}

fun String.validatePassword(): Boolean {
    return passwordMatcher.matcher(this).matches()
}