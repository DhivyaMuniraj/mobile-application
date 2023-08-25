package com.ces.androidappkit.fcm

import android.app.Application
import android.os.Handler
import android.os.Looper
import com.ces.androidframework.log_helper.LogUtils
import com.google.firebase.messaging.FirebaseMessagingService
import com.google.firebase.messaging.RemoteMessage
import dagger.hilt.android.AndroidEntryPoint
import javax.inject.Inject

private const val TAG = "AppFireBaseMessagingService"

@AndroidEntryPoint
class AppFireBaseMessagingService : FirebaseMessagingService() {

    @Inject
    lateinit var app: Application

    // Fetch the remote message from the FCM
    override fun onMessageReceived(remoteMessage: RemoteMessage) {
        super.onMessageReceived(remoteMessage)
        handleMessage(remoteMessage)
        LogUtils.debug(TAG, "notification onMessageReceived")
    }

    // Handling the raw remote message from the server
    private fun handleMessage(remoteMessage: RemoteMessage) {
        LogUtils.debug(TAG, "handleMessage")
        val handler = Handler(Looper.getMainLooper())
        handler.post(Runnable {
            remoteMessage.notification?.let {
                LogUtils.debug(TAG, "notification ${it.body}")
            }
        }
        )
    }


    /**
     * Called if the FCM registration token is updated. This may occur if the security of
     * the previous token had been compromised. Note that this is called when the
     * FCM registration token is initially generated so this is where you would retrieve the token.
     */
    override fun onNewToken(token: String) {
        LogUtils.debug(TAG, "Refreshed token: $token")
    }

}