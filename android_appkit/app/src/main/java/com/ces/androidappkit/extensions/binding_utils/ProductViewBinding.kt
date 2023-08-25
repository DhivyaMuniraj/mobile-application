package com.ces.androidappkit.extensions.binding_utils

import android.widget.ImageView
import androidx.databinding.BindingAdapter
import com.bumptech.glide.Glide
import com.ces.androidappkit.R

@BindingAdapter("isFavouriteBinding")
fun isFavouriteBinding(view: ImageView, isFavourite: Boolean?) {
    val imageDrawable = if (isFavourite!!) R.drawable.ic_heart_on else R.drawable.ic_heart_off
    Glide.with(view.context).load(imageDrawable).into(view)
}