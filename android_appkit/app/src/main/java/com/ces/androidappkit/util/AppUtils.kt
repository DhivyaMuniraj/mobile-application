package com.ces.androidappkit.util

import android.animation.ObjectAnimator
import android.app.Activity
import android.content.Context
import android.content.DialogInterface
import android.content.Intent
import android.graphics.drawable.GradientDrawable
import android.os.Build
import android.os.CountDownTimer
import android.os.Handler
import android.os.Looper
import android.text.Spannable
import android.text.SpannableString
import android.text.style.ForegroundColorSpan
import android.text.style.StyleSpan
import android.text.style.UnderlineSpan
import android.view.View
import android.view.ViewGroup
import android.view.ViewTreeObserver
import android.view.animation.AnticipateInterpolator
import android.widget.TextView
import androidx.activity.OnBackPressedCallback
import androidx.annotation.RequiresApi
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import androidx.core.animation.doOnEnd
import androidx.core.app.ActivityCompat
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentActivity
import androidx.localbroadcastmanager.content.LocalBroadcastManager
import com.ces.androidappkit.R
import com.ces.androidappkit.databinding.AppWideMessageLayoutBinding
import com.ces.androidappkit.databinding.CustomToolbarBinding
import com.ces.androidappkit.databinding.DefaultToolbarBinding
import com.ces.androidappkit.ui.home.ActivityHome
import com.ces.androidframework.contexthelper.dp2px
import com.ces.androidframework.log_helper.LogUtils
import id.zelory.compressor.Compressor
import id.zelory.compressor.constraint.quality
import id.zelory.compressor.constraint.resolution
import id.zelory.compressor.constraint.size
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.async
import java.io.File
import java.text.ParseException
import java.text.SimpleDateFormat
import java.util.*


private const val TAG = "AppUtils"

/**
 * Holds the miscellaneous data, functions, common utilities,
 * and access helpers to be used within the app context
 */
class AppUtils {

    companion object {

        fun startCountDownTimer(
            millisInFuture: Long,
            countDownInterval: Long,
            onTick: (p0: Long) -> Unit = {},
            onComplete: () -> Unit = {}
        ): CountDownTimer {
            val countDownTimer = object : CountDownTimer(millisInFuture, countDownInterval) {
                override fun onTick(p0: Long) {
                    onTick(p0)
                }

                override fun onFinish() {
                    onComplete()
                }
            }.start()
            return countDownTimer
        }

        fun disableTouchForView(view: View) {
            view.setOnTouchListener { v, event -> true }
        }

        fun removeRepeatedValues(list: List<String>?): List<String> {
            return LinkedHashSet(list).toMutableList()
        }

        fun uniqueId(): String? {
            return UUID.randomUUID().toString().replace("-".toRegex(), "")
                .uppercase(Locale.getDefault())
        }

        fun uniqueId(countOfString: Int): String? {
            return UUID.randomUUID().toString().replace("-".toRegex(), "")
                .lowercase(Locale.getDefault()).substring(0, countOfString)
        }

        fun uniqueId24(): String? {
            return uniqueId(24)
        }

        fun uniqueId16(): String? {
            return uniqueId(16)
        }

        fun sendBroadcastForCustomEvent(
            context: Context?,
            eventType: String?,
            eventMessage: String?
        ) {
            val intent = Intent(Constants.Companion.EventConstants.APP_EVENT_RECEIVER)
            intent.putExtra(Constants.Companion.EventConstants.APP_EVENT_TYPE, eventType)
            intent.putExtra(Constants.Companion.EventConstants.APP_EVENT_MESSAGE, eventMessage)
            intent.action = Constants.Companion.EventConstants.APP_EVENT_RECEIVER
            LocalBroadcastManager.getInstance(context!!).sendBroadcast(intent)
        }

        fun getIsoDateTimeStamp(daysInPast: Int, outputFormat: String): String {
            var dateTimeStamp = ""
            val calendar = Calendar.getInstance()
            calendar.add(Calendar.DAY_OF_YEAR, -daysInPast)
            dateTimeStamp = calendar.timeInMillis.provideDateString(outputFormat)!!
            return dateTimeStamp
        }

        fun getFormattedDate(
            serverDate: String,
            formatInComing: String,
            expectedFormat: String
        ): String {
            val outputFormat = SimpleDateFormat(expectedFormat)
            var outputString = ""
            try {
                val inputDate = serverDate.getDateWithServerTimeStamp(formatInComing)
                val formattedDate = outputFormat.format(inputDate)
                outputString = formattedDate
            } catch (e: Exception) {
                e.printStackTrace()
            }
            return outputString
        }

        fun disableViewForExpectedDuration(view: View, duration: Long = 1200) {
            view.isEnabled = false
            view.alpha = 1f
            Handler(Looper.getMainLooper()).postDelayed(Runnable {
                view.isEnabled = true
                view.alpha = 1f
            }, duration)
        }

        fun enableDisableView(view: View, isEnabled: Boolean) {
            view.isEnabled = isEnabled
            view.alpha = if (isEnabled) 1f else 0.5f
        }

        fun setGradientDrawableBackground(
            v: View,
            backgroundColor: Int,
            borderColor: Int,
            cornerRadius: Float = 8f,
            strokeWidth: Int = 1
        ) {
            val shape = GradientDrawable()
            shape.shape = GradientDrawable.RECTANGLE
            shape.cornerRadii = floatArrayOf(
                cornerRadius,
                cornerRadius,
                cornerRadius,
                cornerRadius,
                cornerRadius,
                cornerRadius,
                cornerRadius,
                cornerRadius
            )
            shape.setColor(backgroundColor)
            shape.setStroke(strokeWidth, borderColor)
            v.background = shape
        }

        fun setGradientDrawableStrokeColor(
            context: Context,
            layout: ViewGroup,
            color: Int
        ) {
            var gd = layout.background as GradientDrawable
            gd = gd.mutate() as GradientDrawable
            gd.setStroke(context.dp2px(1), color)
        }

        fun updateUiForStates(context: Context, targetView: View, currentState: String) {
            var backgroundColor = context.getColor(R.color.text_container)
            var strokeColor = context.getColor(R.color.text_container)
            when (currentState) {
                Constants.Companion.UiStateConstants.FIELD_DEFAULT_WITH_PLACE_HOLDER -> {
                    backgroundColor = context.getColor(R.color.text_container)
                    strokeColor = context.getColor(R.color.text_container)
                }
                Constants.Companion.UiStateConstants.FIELD_FILLED -> {
                    backgroundColor = context.getColor(R.color.text_container)
                    strokeColor = context.getColor(R.color.text_box_out_line)
                }
                Constants.Companion.UiStateConstants.FIELD_TYPING -> {
                    backgroundColor = context.getColor(R.color.white)
                    strokeColor = context.getColor(R.color.primary_blue)
                }
                Constants.Companion.UiStateConstants.FIELD_SUCCESS -> {
                    backgroundColor = context.getColor(R.color.white)
                    strokeColor = context.getColor(R.color.success_color)
                }
                Constants.Companion.UiStateConstants.FIELD_ERROR -> {
                    backgroundColor = context.getColor(R.color.white)
                    strokeColor = context.getColor(R.color.error_color)
                }
                Constants.Companion.UiStateConstants.FIELD_DISABLED -> {
                    backgroundColor = context.getColor(R.color.secondary_grey)
                    strokeColor = context.getColor(R.color.secondary_grey)
                }
                Constants.Companion.UiStateConstants.FIELD_WITH_CAPTION -> {
                    backgroundColor = context.getColor(R.color.text_container)
                    strokeColor = context.getColor(R.color.text_container)
                }
            }
            setGradientDrawableBackground(
                targetView,
                backgroundColor,
                strokeColor,
                50f
            )
        }

    }

}

fun TextView.attributedString(
    forText: String,
    foregroundColor: Int? = null,
    style: StyleSpan? = null,
    underline: Boolean = false
) {
    val spannable: Spannable = SpannableString(text)
    if (forText.isEmpty()) {
        return
    }
    val startIdx = text.indexOf(forText)
    val endIdx = startIdx + forText.length
    if (startIdx < 0 || endIdx > text.length) {
        return
    }
    foregroundColor?.let {
        spannable.setSpan(
            ForegroundColorSpan(it),
            startIdx,
            endIdx,
            Spannable.SPAN_INCLUSIVE_EXCLUSIVE
        )
    }
    style?.let {
        spannable.setSpan(
            style,
            startIdx,
            endIdx,
            Spannable.SPAN_INCLUSIVE_EXCLUSIVE
        )
    }
    if (underline) {
        style?.let {
            spannable.setSpan(
                UnderlineSpan(),
                startIdx, // start
                endIdx, // end
                Spannable.SPAN_EXCLUSIVE_INCLUSIVE
            )
        }
    }
    text = spannable
}

fun Activity.showAlertDialog(
    message: String,
    positiveButtonClick: (DialogInterface, Int) -> Unit,
) {
    val builder = AlertDialog.Builder(this)
    //set content message
    builder.setMessage(message)
    //set positive button
    builder.setPositiveButton("Ok", positiveButtonClick)
    builder.show()
}

fun Activity.showAlertDialog(message: String) {
    val builder = AlertDialog.Builder(this)
    //set content message
    builder.setMessage(message)
    //set positive button
    builder.setPositiveButton(
        getString(R.string.ok)
    ) { dialog, id ->
        dialog.dismiss()
    }
    builder.show()
}

fun Activity.navigateTo(classToMoveTo: Class<*>, finishCurrent: Boolean = false) {
    ActivityCompat.startActivity(
        this,
        Intent(this, classToMoveTo),
        null
    )
    if (finishCurrent) {
        finish()
    }
}

fun Fragment.navigateTo(classToMoveTo: Class<*>, finishCurrent: Boolean = false) {
    ActivityCompat.startActivity(
        requireActivity(),
        Intent(requireActivity(), classToMoveTo),
        null
    )
    if (finishCurrent) {
        requireActivity().finish()
    }
}

fun Activity.navigateViaIntent(intent: Intent, finishCurrent: Boolean = false) {
    ActivityCompat.startActivity(
        this,
        intent,
        null
    )
    if (finishCurrent) {
        finish()
    }
}

fun Fragment.navigateViaIntent(intent: Intent, finishCurrent: Boolean = false) {
    ActivityCompat.startActivity(
        requireContext(),
        intent,
        null
    )
    if (finishCurrent) {
        requireActivity().finish()
    }
}

fun Activity.openDialogWithOptions(
    title: String = "",
    message: String,
    positiveButtonText: String = getString(R.string.yes),
    negativeButtonText: String = getString(R.string.no),
    positiveButtonClick: (DialogInterface, Int) -> Unit,
    negativeButtonClick: (DialogInterface, Int) -> Unit
) {
    val builder = AlertDialog.Builder(this)
    if (title.isNotEmpty()) {
        builder.setTitle(title)
    }
    builder.setMessage(message)
    builder.setPositiveButton(positiveButtonText, positiveButtonClick)
    builder.setNegativeButton(negativeButtonText, negativeButtonClick)
    builder.show()
}

fun Activity.showLog(value: String) {
    LogUtils.debug(TAG, value)
}

fun Fragment.showLog(value: String) {
    LogUtils.debug(TAG, value)
}

fun Fragment.showAlertDialog(message: String) {
    val builder = AlertDialog.Builder(requireActivity())
    //set content message
    builder.setMessage(message)
    //set positive button
    builder.setPositiveButton(
        getString(R.string.ok)
    ) { dialog, id ->
        dialog.dismiss()
    }
    builder.show()
}

fun Fragment.showAlertDialog(
    message: String,
    positiveButtonClick: (DialogInterface, Int) -> Unit,
) {
    val builder = AlertDialog.Builder(requireActivity())
    //set content message
    builder.setMessage(message)
    //set positive button
    builder.setPositiveButton(getString(R.string.ok), positiveButtonClick)
    builder.show()
}

/** Converting from String to Date **/
fun String.getDateWithServerTimeStamp(dateFormat: String): Date? {
    val dateFormatUpdated = SimpleDateFormat(
        dateFormat,
        Locale.getDefault()
    )
    dateFormatUpdated.timeZone = TimeZone.getTimeZone("GMT")  // IMP !!!
    return try {
        dateFormatUpdated.parse(this)
    } catch (e: ParseException) {
        null
    }
}

/** Converting from Date to String**/
fun Date.getStringTimeStampWithDate(dateFormat: String): String {
    val dateFormat = SimpleDateFormat(
        dateFormat,
        Locale.getDefault()
    )
    dateFormat.timeZone = TimeZone.getTimeZone("GMT")
    return dateFormat.format(this)
}

suspend fun Context.getCompressedFile(filePath: String): File {
    val file = File(filePath)
    val sizeInMb: Long = file.length() / (1024 * 1024)
    LogUtils.debug(TAG, "Raw File Size in Bytes ${file.length()}")
    LogUtils.debug(TAG, "Raw File Size in Mb ${sizeInMb}")

    val compressedFile = GlobalScope.async {
        val compressedImageFile = Compressor.compress(applicationContext, file) {
            resolution(1280, 720)
            quality(80)
            size(3_097_152) // 2 MB
        }
        val sizeInMbCompressed: Long = compressedImageFile.length() / (1024 * 1024)
        LogUtils.debug(TAG, sizeInMbCompressed.toString())
        compressedImageFile
    }
    return compressedFile.await()
}

fun Long.provideDateString(outputFormat: String): String? {
    return try {
        val sdf = SimpleDateFormat(outputFormat, Locale.getDefault())
        val netDate = Date(this)
        sdf.format(netDate)
    } catch (e: Exception) {
        e.toString()
    }
}

//Splash API 12
fun Activity.setUpSplash() {
    // Set up an OnPreDrawListener to the root view.
    val content: View = findViewById(android.R.id.content)
    content.viewTreeObserver.addOnPreDrawListener(
        object : ViewTreeObserver.OnPreDrawListener {
            override fun onPreDraw(): Boolean {
                // Check if the initial data is ready, Change this to the required custom condition
                return if (true) {
                    // The content is ready; start drawing.
                    content.viewTreeObserver.removeOnPreDrawListener(this)
                    true
                } else {
                    // The content is not ready; suspend.
                    false
                }
            }
        })
}

//Splash API 12: Animations
@RequiresApi(Build.VERSION_CODES.S)
fun Activity.setAnimationsForSplash() {
    // Add a callback that's called when the splash screen is animating to
    // the app content.
    splashScreen.setOnExitAnimationListener { splashScreenView ->
        // Create your custom animation.
        val slideUp = ObjectAnimator.ofFloat(
            splashScreenView,
            View.TRANSLATION_Y,
            0f,
            -splashScreenView.height.toFloat()
        )
        slideUp.interpolator = AnticipateInterpolator()
        slideUp.duration = 200L

        // Call SplashScreenView.remove at the end of your custom animation.
        slideUp.doOnEnd { splashScreenView.remove() }

        // Run your animation.
        slideUp.start()
    }
}

// Handling On back pressed deprecation
fun FragmentActivity.onBackPressed(callback: () -> Unit) {
    onBackPressedDispatcher.addCallback(
        this,
        object : OnBackPressedCallback(true) {
            override fun handleOnBackPressed() {
                callback()
            }
        }
    )
}

// Handling On back pressed deprecation
fun AppCompatActivity.onBackPressed(callback: () -> Unit) {
    onBackPressedDispatcher.addCallback(
        this,
        object : OnBackPressedCallback(true) {
            override fun handleOnBackPressed() {
                callback()
            }
        }
    )
}

// Setting custom toolbar title for activities other than Main
fun AppCompatActivity.setCustomToolBarTitle(viewRoot: View, title: String) {
    val binding: CustomToolbarBinding = CustomToolbarBinding.bind(viewRoot)
    binding.tvTitle.text = title
    binding.ivBack.setOnClickListener {
        finish()
    }
}

// Show Custom Alert message
fun AppCompatActivity.showCustomAlertMessageUi(
    isForMain: Boolean,
    viewRoot: View,
    message: String?
) {
    try {
        val binding: AppWideMessageLayoutBinding = if (isForMain) {
            val rootBinding: DefaultToolbarBinding = DefaultToolbarBinding.bind(viewRoot)
            AppWideMessageLayoutBinding.bind(rootBinding.appWideMessageLayout.clRootNoInternet)
        } else {
            val rootBinding: CustomToolbarBinding = CustomToolbarBinding.bind(viewRoot)
            AppWideMessageLayoutBinding.bind(rootBinding.appWideMessageLayout.clRootNoInternet)
        }
        binding.clRootNoInternet.visibility = View.VISIBLE
        message?.let {
            binding.tvMessage.text = it
        }
    } catch (e: Exception) {
        LogUtils.debug(TAG, e.toString())
    }
}

// Hide Custom Alert message
fun AppCompatActivity.hideCustomAlertMessageUi(isForMain: Boolean, viewRoot: View) {
    try {
        val binding: AppWideMessageLayoutBinding = if (isForMain) {
            val rootBinding: DefaultToolbarBinding = DefaultToolbarBinding.bind(viewRoot)
            AppWideMessageLayoutBinding.bind(rootBinding.appWideMessageLayout.clRootNoInternet)
        } else {
            val rootBinding: CustomToolbarBinding = CustomToolbarBinding.bind(viewRoot)
            AppWideMessageLayoutBinding.bind(rootBinding.appWideMessageLayout.clRootNoInternet)
        }
        binding.clRootNoInternet.visibility = View.GONE
    } catch (e: Exception) {
        LogUtils.debug(TAG, e.toString())
    }
}

fun Fragment.showCustomAlertMessageUi(viewRoot: View, message: String?) {
    try {
        if (isVisible) {
            (requireActivity() as ActivityHome).showCustomAlertMessageUi(true, viewRoot, message)
        }
    } catch (e: Exception) {
        LogUtils.debug(TAG, e.toString())
    }
}

fun Fragment.hideCustomAlertMessageUi(viewRoot: View) {
    try {
        if (isVisible) {
            (requireActivity() as ActivityHome).hideCustomAlertMessageUi(true, viewRoot)
        }
    } catch (e: Exception) {
        LogUtils.debug(TAG, e.toString())
    }
}


fun AppCompatActivity.showNoInternetUI(isForMain: Boolean, viewRoot: View) {
    try {
        showCustomAlertMessageUi(isForMain, viewRoot, getString(R.string.no_internet_message))
    } catch (e: Exception) {
        LogUtils.debug(TAG, e.toString())
    }
}

fun AppCompatActivity.hideNoInternetUi(isForMain: Boolean, viewRoot: View) {
    try {
        hideCustomAlertMessageUi(isForMain, viewRoot)
    } catch (e: Exception) {
        LogUtils.debug(TAG, e.toString())
    }
}

fun Fragment.showNoInternetUI(viewRoot: View) {
    try {
        if (isVisible) {
            (requireActivity() as ActivityHome).showNoInternetUI(true, viewRoot)
        }
    } catch (e: Exception) {
        LogUtils.debug(TAG, e.toString())
    }
}

fun Fragment.hideNoInternetUi(viewRoot: View) {
    try {
        if (isVisible) {
            (requireActivity() as ActivityHome).hideNoInternetUi(true, viewRoot)
        }
    } catch (e: Exception) {
        LogUtils.debug(TAG, e.toString())
    }
}
