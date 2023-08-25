package com.ces.androidappkit.ui.on_boarding

import android.os.Build
import android.os.Bundle
import android.view.View
import androidx.activity.viewModels
import androidx.annotation.RequiresApi
import androidx.appcompat.app.AppCompatActivity
import androidx.core.widget.addTextChangedListener
import androidx.lifecycle.lifecycleScope
import com.ces.androidappkit.R
import com.ces.androidappkit.databinding.ActivityOnBoardingBinding
import com.ces.androidappkit.ui.home.ActivityHome
import com.ces.androidappkit.util.AppUtils
import com.ces.androidappkit.util.Constants
import com.ces.androidappkit.util.navigateTo
import com.ces.androidappkit.util.network_helper.ConnectionLiveData
import com.ces.androidappkit.util.network_helper.ConnectivityObserver
import com.ces.androidappkit.util.network_helper.NetworkConnectivityObserver
import com.ces.androidappkit.util.setUpSplash
import com.ces.androidframework.contexthelper.hasInternetCapabilities
import com.ces.androidframework.log_helper.LogUtils
import dagger.hilt.android.AndroidEntryPoint
import kotlinx.coroutines.flow.launchIn
import kotlinx.coroutines.flow.onEach

private const val TAG = "ActivityOnBoarding"

@AndroidEntryPoint
class ActivityOnBoarding : AppCompatActivity() {

    private lateinit var binding: ActivityOnBoardingBinding
    private lateinit var connectionLiveData: ConnectionLiveData
    private val viewModel: ViewModelOnBoarding by viewModels()
    private val cornerRadiusForToggleView = 50f

    private lateinit var connectivityObserver: ConnectivityObserver//

    @RequiresApi(Build.VERSION_CODES.S)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setUpSplash()
        binding = ActivityOnBoardingBinding.inflate(layoutInflater)
        setContentView(binding.root)
        setUi()
        applyClickListeners()
        handleTextListeners()

    }

    private fun handleTextListeners() {
        binding.apply {
            etEmail.addTextChangedListener {
                viewModel.validateEmail(it.toString().trim())
            }
            etPassword.addTextChangedListener {
                viewModel.validatePassword(it.toString().trim())
            }
            etRetypePassword.addTextChangedListener {
                viewModel.validateConfirmPassword(it.toString().trim())
            }
        }
    }

    private fun setUi() {
        setToggleViews(true)
        setBackGroundForToggleView()
        setBackGroundForTextFields()
        setUiForLoginButton(true)
        setUpObservers(true)
    }

    private fun setUiForLoginButton(isForLogin: Boolean) {
        val label = if (isForLogin) getString(R.string.login) else getString(R.string.signup)
        binding.apply {
            binding.tvSubmit.text = label
            AppUtils.setGradientDrawableBackground(
                tvSubmit,
                getColor(R.color.primary_blue),
                getColor(R.color.primary_blue),
                cornerRadiusForToggleView
            )
            AppUtils.enableDisableView(tvSubmit, false)
        }
    }

    private fun applyClickListeners() {
        binding.apply {
            tvLogin.setOnClickListener {
                setToggleViews(true)
                setUiForLoginButton(true)
                setUpObservers(true)
            }
            tvSignUp.setOnClickListener {
                setToggleViews(false)
                setUiForLoginButton(false)
                setUpObservers(false)
            }
            tvSubmit.setOnClickListener {
                navigateTo(ActivityHome::class.java, true)
            }
        }
    }

    private fun setBackGroundForToggleView() {
        AppUtils.setGradientDrawableBackground(
            binding.clToggleView,
            getColor(R.color.text_container),
            getColor(R.color.text_box_out_line),
            cornerRadiusForToggleView
        )
    }

    private fun setBackGroundForTextFields() {
        binding.apply {
            AppUtils.setGradientDrawableBackground(
                clEnterEmail,
                getColor(R.color.text_container),
                getColor(R.color.text_box_out_line),
                cornerRadiusForToggleView
            )
            AppUtils.setGradientDrawableBackground(
                clEnterPassword,
                getColor(R.color.text_container),
                getColor(R.color.text_box_out_line),
                cornerRadiusForToggleView
            )

            AppUtils.setGradientDrawableBackground(
                clReEnterPassword,
                getColor(R.color.text_container),
                getColor(R.color.text_box_out_line),
                cornerRadiusForToggleView
            )
        }
    }

    private fun setToggleViews(isForLogin: Boolean) {
        binding.apply {
            if (isForLogin) {
                tvLogin.setTextColor(getColor(R.color.white))
                tvSignUp.setTextColor(getColor(R.color.primary_blue))
                AppUtils.setGradientDrawableBackground(
                    tvLogin,
                    getColor(R.color.primary_blue),
                    getColor(R.color.primary_blue),
                    cornerRadiusForToggleView
                )
                tvSignUp.background = null
                tvForgotPassword.visibility = View.VISIBLE
                clReEnterPassword.visibility = View.GONE
                etEmail.hint = getString(R.string.enter_email_or_username)
            } else {
                tvLogin.setTextColor(getColor(R.color.primary_blue))
                tvSignUp.setTextColor(getColor(R.color.white))
                AppUtils.setGradientDrawableBackground(
                    tvSignUp,
                    getColor(R.color.primary_blue),
                    getColor(R.color.primary_blue),
                    cornerRadiusForToggleView
                )
                tvLogin.background = null
                tvForgotPassword.visibility = View.GONE
                clReEnterPassword.visibility = View.VISIBLE
                etEmail.hint = getString(R.string.enter_email)
            }
        }
    }

    override fun onResume() {
        super.onResume()
        checkConnectionStatus()
        observeConnectionStatus()
    }

    override fun onPause() {
        super.onPause()
        connectionLiveData.removeObservers(this)
    }

    private fun checkConnectionStatus() {
        if (!hasInternetCapabilities) {
            LogUtils.error(TAG, "Has no internet, on resume")
        }
        connectionLiveData = ConnectionLiveData(application)
        connectionLiveData.observe(this) {
            when (it) {
                true -> {
                    LogUtils.error(TAG, "Internet available")
                }
                false -> {
                    LogUtils.error(TAG, "Internet unavailable")
                }
            }
        }
    }

    private fun observeConnectionStatus() {
        connectivityObserver = NetworkConnectivityObserver(applicationContext)
        connectivityObserver.observe().onEach {
            LogUtils.debug(TAG, it)
        }.launchIn(lifecycleScope)
    }

    private fun setUpObservers(isForLogin: Boolean) {
        viewModel.getUiStatus().observe(this) {
            when (it) {
                UiState.EMPTY_EMAIL -> {
                    viewModel.isValidEmail = false
                    AppUtils.updateUiForStates(
                        this,
                        binding.clEnterEmail,
                        Constants.Companion.UiStateConstants.FIELD_DEFAULT_WITH_PLACE_HOLDER
                    )
                }
                UiState.INVALID_EMAIL -> {
                    viewModel.isValidEmail = false
                    AppUtils.updateUiForStates(
                        this,
                        binding.clEnterEmail,
                        Constants.Companion.UiStateConstants.FIELD_ERROR
                    )
                }
                UiState.EMPTY_PASSWORD -> {
                    viewModel.isValidPassword = false
                    AppUtils.updateUiForStates(
                        this,
                        binding.clEnterPassword,
                        Constants.Companion.UiStateConstants.FIELD_DEFAULT_WITH_PLACE_HOLDER
                    )
                }
                UiState.INVALID_PASSWORD -> {
                    viewModel.isValidPassword = false
                    AppUtils.updateUiForStates(
                        this,
                        binding.clEnterPassword,
                        Constants.Companion.UiStateConstants.FIELD_ERROR
                    )
                }
                UiState.EMPTY_CONFIRM_PASSWORD -> {
                    viewModel.isValidConfirmPassword = false
                    AppUtils.updateUiForStates(
                        this,
                        binding.clReEnterPassword,
                        Constants.Companion.UiStateConstants.FIELD_DEFAULT_WITH_PLACE_HOLDER
                    )
                }
                UiState.INVALID_CONFIRM_PASSWORD -> {
                    viewModel.isValidConfirmPassword = false
                    AppUtils.updateUiForStates(
                        this,
                        binding.clReEnterPassword,
                        Constants.Companion.UiStateConstants.FIELD_ERROR
                    )
                }
                UiState.VALID_EMAIL -> {
                    viewModel.isValidEmail = true
                    AppUtils.updateUiForStates(
                        this,
                        binding.clEnterEmail,
                        Constants.Companion.UiStateConstants.FIELD_SUCCESS
                    )
                }
                UiState.VALID_PASSWORD -> {
                    viewModel.isValidPassword = true
                    AppUtils.updateUiForStates(
                        this,
                        binding.clEnterPassword,
                        Constants.Companion.UiStateConstants.FIELD_SUCCESS
                    )
                }
                UiState.VALID_CONFIRM_PASSWORD -> {
                    viewModel.isValidConfirmPassword = true
                    AppUtils.updateUiForStates(
                        this,
                        binding.clReEnterPassword,
                        Constants.Companion.UiStateConstants.FIELD_SUCCESS
                    )
                }
            }
            enableSubmitButton(isForLogin)
        }

    }

    private fun enableSubmitButton(isForLogin: Boolean) {
        binding.apply {
            val passwordMatches =
                etPassword.text.toString() == etRetypePassword.text.toString()
            val isSubmitEnabled =
                if (isForLogin)
                    viewModel.isValidEmail && viewModel.isValidPassword
                else
                    viewModel.isValidEmail && viewModel.isValidPassword && viewModel.isValidConfirmPassword && passwordMatches
            AppUtils.enableDisableView(tvSubmit, isSubmitEnabled)
        }
    }

}