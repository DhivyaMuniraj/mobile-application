package com.ces.androidappkit.ui.on_boarding

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.ces.androidappkit.extensions.validation_helper.validateEmail
import com.ces.androidappkit.extensions.validation_helper.validatePassword
import dagger.hilt.android.lifecycle.HiltViewModel
import javax.inject.Inject

@HiltViewModel
class ViewModelOnBoarding @Inject constructor() : ViewModel() {

    private var uiState = MutableLiveData<UiState>()
    fun getUiStatus(): LiveData<UiState> {
        return uiState
    }

    var isValidEmail: Boolean = false
    var isValidPassword: Boolean = false
    var isValidConfirmPassword: Boolean = false


    fun validateEmail(email: String) {
        when {
            email.isBlank() -> {
                uiState.postValue(UiState.EMPTY_EMAIL)
                return
            }
            !email.validateEmail() -> {
                uiState.postValue(UiState.INVALID_EMAIL)
                return
            }
            else -> {
                uiState.postValue(UiState.VALID_EMAIL)
            }
        }
    }

    fun validatePassword(password: String) {
        when {
            password.isBlank() -> {
                uiState.postValue(UiState.EMPTY_PASSWORD)
                return
            }
            !password.validatePassword() -> {
                uiState.postValue(UiState.INVALID_PASSWORD)
                return
            }
            else -> {
                uiState.postValue(UiState.VALID_PASSWORD)
            }
        }
    }

    fun validateConfirmPassword(password: String) {
        when {
            password.isBlank() -> {
                uiState.postValue(UiState.EMPTY_CONFIRM_PASSWORD)
                return
            }
            !password.validatePassword() -> {
                uiState.postValue(UiState.INVALID_CONFIRM_PASSWORD)
                return
            }
            else -> {
                uiState.postValue(UiState.VALID_CONFIRM_PASSWORD)
            }
        }
    }

}