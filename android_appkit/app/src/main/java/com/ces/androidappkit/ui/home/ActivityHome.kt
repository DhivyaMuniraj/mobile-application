package com.ces.androidappkit.ui.home

import android.os.Build
import android.os.Bundle
import android.view.Gravity
import androidx.annotation.RequiresApi
import androidx.appcompat.app.AppCompatActivity
import androidx.navigation.findNavController
import androidx.navigation.ui.AppBarConfiguration
import androidx.navigation.ui.setupWithNavController
import com.ces.androidappkit.R
import com.ces.androidappkit.databinding.ActivityMainBinding
import com.ces.androidappkit.ui.profile.ActivityProfile
import com.ces.androidappkit.util.hideNoInternetUi
import com.ces.androidappkit.util.navigateTo
import com.ces.androidappkit.util.network_helper.ConnectionLiveData
import com.ces.androidappkit.util.onBackPressed
import com.ces.androidappkit.util.showNoInternetUI
import com.ces.androidframework.contexthelper.hasInternetCapabilities
import com.google.android.material.bottomnavigation.BottomNavigationView

private const val TAG = "ActivityHome"

class ActivityHome : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding
    private lateinit var connectionLiveData: ConnectionLiveData

    @RequiresApi(Build.VERSION_CODES.S)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)
        setUpBottomNavigation()
        setUpDrawer()
        applyClickListeners()
    }

    private fun applyClickListeners() {
        binding.customToolbar.ivMenu.setOnClickListener {
            openDrawer()
        }
        binding.customToolbar.ivProfile.setOnClickListener {
            //open profile screen
            navigateTo(ActivityProfile::class.java)
        }
        onBackPressed {
            if (binding.drawerLayout.isOpen) {
                binding.drawerLayout.closeDrawer(Gravity.LEFT)
            } else {
                finish()
            }
        }
    }

    private fun setUpDrawer() {
        supportActionBar?.setDisplayHomeAsUpEnabled(true)
    }

    private fun openDrawer() {
        binding.drawerLayout.openDrawer(Gravity.LEFT)
    }

    private fun closeDrawer() {
        binding.drawerLayout.closeDrawer(Gravity.LEFT)
    }

    private fun setUpBottomNavigation() {
        val navView: BottomNavigationView = binding.navView
        val navController = findNavController(R.id.nav_host_fragment_activity_main)
        // Passing each menu ID as a set of Ids because each
        // menu should be considered as top level destinations.
        val appBarConfiguration = AppBarConfiguration(
            setOf(
                R.id.navigation_home,
                R.id.navigation_search,
                R.id.navigation_cart,
                R.id.navigation_categories
            )
        )
//        setupActionBarWithNavController(navController, appBarConfiguration)
        navView.setupWithNavController(navController)
    }

    override fun onResume() {
        super.onResume()
        checkConnectionStatus()
    }

    override fun onPause() {
        super.onPause()
        connectionLiveData.removeObservers(this)
    }


    private fun checkConnectionStatus() {
        if (!hasInternetCapabilities) {
            showNoInternetUI(true, binding.container)
        }
        connectionLiveData = ConnectionLiveData(application)
        connectionLiveData.observe(this) {
            when (it) {
                true -> {
                    hideNoInternetUi(true, binding.container)
                }
                false -> {
                    showNoInternetUI(true, binding.container)
                }
            }
        }
    }

}