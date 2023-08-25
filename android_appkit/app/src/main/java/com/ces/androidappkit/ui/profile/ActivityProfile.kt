package com.ces.androidappkit.ui.profile

import android.os.Build
import android.os.Bundle
import androidx.activity.viewModels
import androidx.annotation.RequiresApi
import androidx.appcompat.app.AppCompatActivity
import com.ces.androidappkit.R
import com.ces.androidappkit.util.network_helper.ConnectionLiveData
import com.ces.androidappkit.databinding.ActivityProfileBinding
import com.ces.androidappkit.util.hideNoInternetUi
import com.ces.androidappkit.util.onBackPressed
import com.ces.androidappkit.util.setCustomToolBarTitle
import com.ces.androidappkit.util.showNoInternetUI
import com.ces.androidframework.contexthelper.hasInternetCapabilities
import com.ces.androidframework.displayMetrics.Screen

private const val TAG = "ActivityProfile"

class ActivityProfile : AppCompatActivity() {

    private lateinit var binding: ActivityProfileBinding
    private lateinit var connectionLiveData: ConnectionLiveData

    private val viewModel: ViewModelProfile by viewModels()

    @RequiresApi(Build.VERSION_CODES.S)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityProfileBinding.inflate(layoutInflater)
        setContentView(binding.root)
        setCustomToolBarTitle(binding.root, getString(R.string.profile))
        setViewDimensions()
        applyClickListeners()
        setObservers()
    }

    private fun setObservers() {
        viewModel.profileDetails.observe(this) {
            binding.model = it
        }
    }

    private fun applyClickListeners() {
        onBackPressed {
            finish()
        }
    }

    override fun onResume() {
        super.onResume()
        checkConnectionStatus()
    }

    override fun onPause() {
        super.onPause()
        connectionLiveData.removeObservers(this)
    }

    private fun setViewDimensions() {
        val heightColumnsLarge = (Screen.height) * 0.22
        binding.slAddress.layoutParams.height = heightColumnsLarge.toInt()
        binding.slContact.layoutParams.height = heightColumnsLarge.toInt()
        binding.slAddress.requestLayout()
        binding.slContact.requestLayout()
    }

    private fun checkConnectionStatus() {
        if (!hasInternetCapabilities) {
            showNoInternetUI(false, binding.root)
        }
        connectionLiveData = ConnectionLiveData(application)
        connectionLiveData.observe(this) {
            when (it) {
                true -> {
                    hideNoInternetUi(false, binding.root)
                }
                false -> {
                    showNoInternetUI(false, binding.root)
                }
            }
        }
    }

}