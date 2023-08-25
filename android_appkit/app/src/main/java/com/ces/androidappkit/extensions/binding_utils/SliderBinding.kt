package com.ces.androidappkit.extensions.binding_utils

import android.widget.TextView
import androidx.databinding.BindingAdapter

@BindingAdapter("percentBinding")
fun percentBinding(view: TextView, percent: Double?) {
    view.text = percent?.toString()
}