package com.ces.androidappkit.extensions.binding_utils

import android.widget.TextView
import androidx.databinding.BindingAdapter

@BindingAdapter("countBinding")
fun countBinding(view: TextView, count: Int?) {
    if (count != null) {
        view.text = if (count > 0) "+${(count - 1)}" else "0"
    } else {
        view.text = "0"
    }
}

@BindingAdapter("labelledMobileBinding")
fun labelledMobileBinding(view: TextView, mobile: String?) {
    view.text = "Mobile: $mobile"
}

@BindingAdapter("labelledEmailBinding")
fun labelledEmailBinding(view: TextView, email: String?) {
    view.text = "Email: $email"
}
