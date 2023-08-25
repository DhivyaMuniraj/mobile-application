package com.ces.androidappkit.ui.profile

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.ces.androidappkit.ui.profile.model.ModelProfile

class ViewModelProfile : ViewModel() {

    private val _profileDetails = MutableLiveData<ModelProfile?>()
    val profileDetails: LiveData<ModelProfile?> = _profileDetails

    init {
        initialiseProfileDetails()
    }

    private fun initialiseProfileDetails() {
        val profileData = ModelProfile(
            "Ujjwal Varsney",
            "Gurugram, Haryana",
            "Ambiance Tower, Sector 44, Gurugram, Haryana PIN: 122003",
            4,
            "+91 1234567890",
            "example@mail.com",
            3
        )
        _profileDetails.postValue(profileData)
    }

}