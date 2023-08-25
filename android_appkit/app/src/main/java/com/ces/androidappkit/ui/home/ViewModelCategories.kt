package com.ces.androidappkit.ui.home

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel

class ViewModelCategories : ViewModel() {

    private val _text = MutableLiveData<String>().apply {
        value = "This is Categories Fragment"
    }
    val text: LiveData<String> = _text
}