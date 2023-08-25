package com.ces.androidappkit.ui.home

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.ces.androidappkit.ui.home.model.ModelProduct
import com.ces.androidappkit.ui.home.model.ModelSlider

class ViewModelDashBoard : ViewModel() {

    private val _sliderList = MutableLiveData<List<ModelSlider>?>()
    val sliderList: LiveData<List<ModelSlider>?> = _sliderList

    private val _productList = MutableLiveData<List<ModelProduct>?>()
    val productList: LiveData<List<ModelProduct>?> = _productList

    init {
        initialiseSliderList()
        initialiseProductList()
    }

    private fun initialiseSliderList() {
        val list = ArrayList<ModelSlider>()
        for (i in 1..3) {
            val modelSlider = ModelSlider((60..70).random().toDouble())
            list.add(modelSlider)
        }
        _sliderList.postValue(list)
    }

    private fun initialiseProductList() {
        val list = ArrayList<ModelProduct>()
        for (i in 1..3) {
            val sliderData = ModelProduct(i.toString(), false)
            list.add(sliderData)
        }
        _productList.postValue(list)
    }

}