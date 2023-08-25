package com.ces.androidframework.viewhelper

import android.animation.*
import android.annotation.SuppressLint
import android.annotation.TargetApi
import android.app.Activity
import android.content.Context
import android.content.res.ColorStateList
import android.content.res.Resources
import android.content.res.TypedArray
import android.graphics.*
import android.graphics.drawable.*
import android.os.Build
import android.os.Handler
import android.os.SystemClock
import android.text.SpannableStringBuilder
import android.text.Spanned
import android.transition.TransitionManager
import android.util.AttributeSet
import android.util.TypedValue
import android.view.*
import android.view.animation.AlphaAnimation
import android.view.animation.OvershootInterpolator
import android.view.inputmethod.InputMethodManager
import android.widget.*
import androidx.activity.ComponentActivity
import androidx.annotation.*
import androidx.appcompat.widget.PopupMenu
import androidx.appcompat.widget.SearchView
import androidx.appcompat.widget.Toolbar
import androidx.constraintlayout.widget.ConstraintLayout
import androidx.constraintlayout.widget.ConstraintSet
import androidx.coordinatorlayout.widget.CoordinatorLayout
import androidx.core.animation.doOnEnd
import androidx.core.content.ContextCompat
import androidx.core.content.getSystemService
import androidx.core.view.*
import androidx.drawerlayout.widget.DrawerLayout
import androidx.fragment.app.Fragment
import androidx.interpolator.view.animation.FastOutSlowInInterpolator
import androidx.recyclerview.widget.RecyclerView
import com.ces.androidframework.miscellaneous.withOpacity
import com.google.android.material.animation.ArgbEvaluatorCompat
import com.google.android.material.appbar.AppBarLayout
import com.google.android.material.bottomsheet.BottomSheetBehavior
import com.google.android.material.floatingactionbutton.FloatingActionButton
import com.google.android.material.snackbar.Snackbar
import com.google.android.material.tabs.TabLayout
import com.google.android.material.textfield.TextInputLayout
import java.lang.reflect.Field
import java.lang.reflect.Method
import kotlin.math.max
import kotlin.math.min
import kotlin.math.roundToInt

class ViewUtils {

    @SuppressLint("AnnotateVersionCheck")
    companion object {

        fun View.visible() {
            this.visibility = View.VISIBLE
        }

        fun View.gone() {
            this.visibility = View.GONE
        }

        fun View.invisible() {
            this.visibility = View.INVISIBLE
        }


        fun TextView.setTextSizeRes(@DimenRes rid: Int) {
            setTextSize(TypedValue.COMPLEX_UNIT_PX, this.context.resources.getDimension(rid))
        }


        fun View.px(@DimenRes rid: Int): Int {
            return this.context.resources.getDimensionPixelOffset(rid)
        }


        val SearchView?.getEditTextSearchView get() = this?.findViewById<EditText>(androidx.appcompat.R.id.search_src_text)


        fun collapseLayout(
            linearLayout: LinearLayout,
            imageView: ImageView,
            dropUPIMG: Int,
            dropDOWNIMG: Int
        ) {
            var firstClick = false

            imageView.setOnClickListener {
                if (firstClick) {

                    TransitionManager.beginDelayedTransition(linearLayout)
                    linearLayout.visibility = View.GONE
                    imageView.setImageResource(dropDOWNIMG)

                    firstClick = false

                } else {
                    TransitionManager.beginDelayedTransition(linearLayout)
                    linearLayout.visibility = View.VISIBLE
                    imageView.setImageResource(dropUPIMG)

                    firstClick = true

                }
            }


        }


        fun adjustAlpha(@ColorInt color: Int, factor: Float): Int {
            val alpha = (Color.alpha(color) * factor).roundToInt()
            val red = Color.red(color)
            val green = Color.green(color)
            val blue = Color.blue(color)
            return Color.argb(alpha, red, green, blue)
        }

        fun View.setPaddingLeft(value: Int) =
            setPadding(value, paddingTop, paddingRight, paddingBottom)

        fun View.setPaddingRight(value: Int) =
            setPadding(paddingLeft, paddingTop, value, paddingBottom)

        fun View.setPaddingTop(value: Int) =
            setPaddingRelative(paddingStart, value, paddingEnd, paddingBottom)

        fun View.setPaddingBottom(value: Int) =
            setPaddingRelative(paddingStart, paddingTop, paddingEnd, value)

        fun View.setPaddingStart(value: Int) =
            setPaddingRelative(value, paddingTop, paddingEnd, paddingBottom)

        fun View.setPaddingEnd(value: Int) =
            setPaddingRelative(paddingStart, paddingTop, value, paddingBottom)

        fun View.setPaddingHorizontal(value: Int) =
            setPaddingRelative(value, paddingTop, value, paddingBottom)

        fun View.setPaddingVertical(value: Int) =
            setPaddingRelative(paddingStart, value, paddingEnd, value)

        fun View.setHeight(newValue: Int) {
            val params = layoutParams
            params?.let {
                params.height = newValue
                layoutParams = params
            }
        }

        fun View.setWidth(newValue: Int) {
            val params = layoutParams
            params?.let {
                params.width = newValue
                layoutParams = params
            }
        }


        fun View.resize(width: Int, height: Int) {
            val params = layoutParams
            params?.let {
                params.width = width
                params.height = height
                layoutParams = params
            }
        }

        /**
         * INVISIBLE TO VISIBLE AND OTHERWISE
         */
        fun View.toggleVisibilityInvisibleToVisible(): View {
            visibility = if (visibility == View.VISIBLE) {
                View.INVISIBLE
            } else {
                View.VISIBLE
            }
            return this
        }

        /**
         * INVISIBLE TO GONE AND OTHERWISE
         */
        fun View.toggleVisibilityGoneToVisible(): View {
            visibility = if (visibility == View.VISIBLE) {
                View.GONE
            } else {
                View.VISIBLE
            }
            return this
        }


        /**
         *  View as bitmap.
         */
        fun View.getBitmap(): Bitmap {
            val bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888)
            val canvas = Canvas(bitmap)
            draw(canvas)
            canvas.save()
            return bitmap
        }

        /**
         * Method to simplify the code needed to apply spans on a specific sub string.
         */
        inline fun SpannableStringBuilder.withSpan(
            vararg spans: Any,
            action: SpannableStringBuilder.() -> Unit
        ):
                SpannableStringBuilder {
            val from = length
            action()

            for (span in spans) {
                setSpan(span, from, length, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE)
            }

            return this
        }

        @UiThread
        fun View.fadeOut() {
            fadeOut(500)
        }

        @UiThread
        fun View.fadeIn() {
            fadeIn(500)
        }

        @UiThread
        fun View.fadeIn(duration: Long) {
            this.clearAnimation()
            val anim = AlphaAnimation(this.alpha, 1.0f)
            anim.duration = duration
            this.startAnimation(anim)
        }

        @UiThread
        fun View.fadeOut(duration: Long) {
            this.clearAnimation()
            val anim = AlphaAnimation(this.alpha, 0.0f)
            anim.duration = duration
            this.startAnimation(anim)
        }


        /**
         * Extension method to remove the required boilerplate for running code after a view has been
         * inflated and measured.
         *
         */
        inline fun <T : View> T.afterMeasured(crossinline function: T.() -> Unit) {
            viewTreeObserver.addOnGlobalLayoutListener(object :
                ViewTreeObserver.OnGlobalLayoutListener {
                override fun onGlobalLayout() {
                    if (measuredWidth > 0 && measuredHeight > 0) {
                        viewTreeObserver.removeOnGlobalLayoutListener(this)
                        function()
                    }
                }
            })
        }


        val View.isVisibile: Boolean
            get() {
                return this.visibility == View.VISIBLE
            }

        val View.isGone: Boolean
            get() {
                return this.visibility == View.GONE
            }

        val View.isInvisible: Boolean
            get() {
                return this.visibility == View.INVISIBLE
            }

        /**
         * Sets color to status bar
         */
        fun Window.addStatusBarColor(@ColorRes color: Int) {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                this.clearFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS)
                this.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS)
                this.statusBarColor = ContextCompat.getColor(this.context, color)
            }
        }

        /**
         * Visible if condition met
         */

        inline fun View.visibleIf(block: () -> Boolean) {
            if (visibility != View.VISIBLE && block()) {
                visible()
            }
        }


        /**
         * Visible if condition met else gone
         */

        inline fun View.visibleIfElseGone(block: () -> Boolean) {
            if (visibility != View.VISIBLE && block()) {
                visible()
            } else {
                gone()
            }
        }


        /**
         * Invisible if condition met
         */

        inline fun View.invisibleIf(block: () -> Boolean) {
            if (visibility != View.INVISIBLE && block()) {
                invisible()
            }
        }


        /**
         * Invisible if condition met
         */

        inline fun View.invisibleIfElseVisible(block: () -> Boolean) {
            if (visibility != View.INVISIBLE && block()) {
                invisible()
            } else {
                visible()
            }
        }


        /**
         * Gone if condition met
         */
        inline fun View.goneIf(block: () -> Boolean) {
            if (visibility != View.GONE && block()) {
                gone()
            }
        }


        /**
         * Gone if condition met
         */
        inline fun View.goneIfElseVisible(block: () -> Boolean) {
            if (visibility != View.GONE && block()) {
                gone()
            } else {
                visible()
            }
        }


        /**
         * Aligns to left of the parent in relative layout
         */
        fun View.alignParentStart() {
            val params = layoutParams as RelativeLayout.LayoutParams?

            params?.apply {
                addRule(RelativeLayout.ALIGN_PARENT_START)
            }

        }


        /**
         * Aligns to right of the parent in relative layout
         */
        fun View.alignParentEnd() {
            val params = layoutParams as RelativeLayout.LayoutParams?

            params?.apply {
                addRule(RelativeLayout.ALIGN_PARENT_END)
            }

        }


        /**
         * Aligns in the center of the parent in relative layout
         */
        fun View.alignInCenter() {
            val params = layoutParams as RelativeLayout.LayoutParams?

            params?.apply {
                addRule(RelativeLayout.CENTER_HORIZONTAL)
            }

        }


        /**
         * Sets margins for views in Linear Layout
         */
        fun View.linearMargins(left: Int, top: Int, right: Int, bottom: Int) {
            val params = layoutParams as LinearLayout.LayoutParams?

            params?.apply {
                setMargins(left, top, right, bottom)
            }

            this.layoutParams = params

        }


        /**
         * Sets margins for views in Linear Layout
         */
        fun View.linearMargins(size: Int) {
            val params = layoutParams as LinearLayout.LayoutParams?

            params?.apply {
                setMargins(size)
            }
            this.layoutParams = params

        }


        /**
         * Sets right margin for views in Linear Layout
         */
        fun View.endLinearMargin(size: Int) {
            val params = layoutParams as LinearLayout.LayoutParams?

            params?.apply {
                marginEnd = size
            }
            this.layoutParams = params

        }


        /**
         * Sets bottom margin for views in Linear Layout
         */
        fun View.bottomLinearMargin(size: Int) {
            val params = layoutParams as LinearLayout.LayoutParams?

            params?.apply {
                setMargins(marginLeft, marginTop, marginRight, size)
            }
            this.layoutParams = params

        }

        /**
         * Sets top margin for views in Linear Layout
         */
        fun View.topLinearMargin(size: Int) {
            val params = layoutParams as LinearLayout.LayoutParams?

            params?.apply {
                setMargins(marginLeft, size, marginRight, marginBottom)
            }
            this.layoutParams = params

        }


        /**
         * Sets top margin for views in Linear Layout
         */
        fun View.startLinearMargin(size: Int) {
            val params = layoutParams as LinearLayout.LayoutParams?

            params?.apply {
                marginStart = size
            }
            this.layoutParams = params

        }


        /**
         * Sets margins for views in Relative Layout
         */
        fun View.relativeMargins(left: Int, top: Int, right: Int, bottom: Int) {
            val params = layoutParams as RelativeLayout.LayoutParams?

            params?.apply {
                setMargins(left, top, right, bottom)
            }
            this.layoutParams = params

        }


        /**
         * Sets margins for views in Relative Layout
         */
        fun View.relativeMargins(size: Int) {
            val params = layoutParams as RelativeLayout.LayoutParams?

            params?.apply {
                setMargins(size)
            }
            this.layoutParams = params

        }


        /**
         * Sets right margin for views in Relative Layout
         */
        fun View.endRelativeMargin(size: Int) {
            val params = layoutParams as RelativeLayout.LayoutParams?

            params?.apply {
                marginEnd = size
            }
            this.layoutParams = params

        }


        /**
         * Sets bottom margin for views in Relative Layout
         */
        fun View.bottomRelativeMargin(size: Int) {
            val params = layoutParams as RelativeLayout.LayoutParams?

            params?.apply {
                setMargins(marginLeft, marginTop, marginRight, size)
            }
            this.layoutParams = params

        }

        /**
         * Sets top margin for views in Relative Layout
         */
        fun View.topRelativeMargin(size: Int) {
            val params = layoutParams as RelativeLayout.LayoutParams?

            params?.apply {
                setMargins(marginLeft, size, marginRight, marginBottom)
            }
            this.layoutParams = params

        }


        /**
         * Sets top margin for views in Relative Layout
         */
        fun View.startRelativeMargin(size: Int) {
            val params = layoutParams as RelativeLayout.LayoutParams?

            params?.apply {
                marginStart = size
            }
            this.layoutParams = params

        }


        /**
         * Sets margins for views
         */
        fun View.setMargins(size: Int) {
            val params = layoutParams as ViewGroup.MarginLayoutParams?

            params?.apply {
                setMargins(size)
            }
            this.layoutParams = params

        }


        /**
         * Sets right margin for views
         */
        fun View.endMargin(size: Int) {
            val params = layoutParams as ViewGroup.MarginLayoutParams?

            params?.apply {
                marginEnd = size
            }
            this.layoutParams = params

        }


        /**
         * Sets bottom margin for views
         */
        fun View.bottomMargin(size: Int) {
            val params = layoutParams as ViewGroup.MarginLayoutParams?

            params?.apply {
                setMargins(marginLeft, marginTop, marginRight, size)
            }
            this.layoutParams = params

        }

        /**
         * Sets top margin for views
         */
        fun View.topMargin(size: Int) {
            val params = layoutParams as ViewGroup.MarginLayoutParams?

            params?.apply {
                setMargins(marginLeft, size, marginRight, marginBottom)
            }
            this.layoutParams = params

        }


        /**
         * Sets top margin for views
         */
        fun View.startMargin(size: Int) {
            val params = layoutParams as ViewGroup.MarginLayoutParams?

            params?.apply {
                marginStart = size
            }
            this.layoutParams = params

        }


        private fun ViewGroup.enableDisableChildren(enable: Boolean): ViewGroup = apply {
            (0 until childCount).forEach {
                when (val view = getChildAt(it)) {
                    is ViewGroup -> view.enableDisableChildren(enable)
                    else -> if (enable) view.enable() else view.disable()
                }
            }
        }

        fun ViewGroup.disableChildren() = enableDisableChildren(false)
        fun ViewGroup.enableChildren() = enableDisableChildren(true)

        fun View.hideIme() {
            val imm = context.getSystemService<InputMethodManager>()
            imm?.hideSoftInputFromWindow(windowToken, 0)
        }

        /**
         * Get color from resources with alpha
         */
        @ColorInt
        @Deprecated(
            message = "Use new [colorWithOpacity] extension",
            replaceWith = ReplaceWith("colorWithOpacity(res, alphaPercent)")
        )
        fun View.colorWithAlpha(
            @ColorRes res: Int,
            @androidx.annotation.IntRange(from = 0, to = 100) alphaPercent: Int
        ): Int {
            return colorWithOpacity(res, alphaPercent)
        }

        /**
         * Get color from resources with applied [opacity]
         */
        @ColorInt
        fun View.colorWithOpacity(
            @ColorRes res: Int,
            @androidx.annotation.IntRange(from = 0, to = 100) opacity: Int
        ): Int {
            return color(res).withOpacity(opacity)
        }


        /**
         * Get bitmap representation of view
         */
        fun View.asBitmap(): Bitmap {
            val b = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888)
            val c = Canvas(b)
            layout(left, top, right, bottom)
            draw(c)
            return b
        }


        /**
         * View artificial attribute that sets compound left drawable
         */
        var TextView.drawableLeft: Int
            get() = throw IllegalAccessException("Property drawableLeft only as setter")
            set(value) {
                val drawables = compoundDrawables
                setCompoundDrawablesWithIntrinsicBounds(
                    ContextCompat.getDrawable(context, value),
                    drawables[1],
                    drawables[2],
                    drawables[3]
                )
            }

        /**
         * View artificial attribute that sets compound right drawable
         */
        var TextView.drawableRight: Int
            get() = throw IllegalAccessException("Property drawableRight only as setter")
            set(value) {
                val drawables = compoundDrawables
                setCompoundDrawablesWithIntrinsicBounds(
                    drawables[0],
                    drawables[1],
                    ContextCompat.getDrawable(context, value),
                    drawables[3]
                )
            }

        /**
         * View artificial attribute that sets compound top drawable
         */
        var TextView.drawableTop: Int
            get() = throw IllegalAccessException("Property drawableTop only as setter")
            set(value) {
                val drawables = compoundDrawables
                setCompoundDrawablesWithIntrinsicBounds(
                    drawables[0],
                    ContextCompat.getDrawable(context, value),
                    drawables[2],
                    drawables[3]
                )
            }

        /**
         * View artificial attribute that sets compound bottom drawable
         */
        var TextView.drawableBottom: Int
            get() = throw IllegalAccessException("Property drawableBottom only as setter")
            set(value) {
                val drawables = compoundDrawables
                setCompoundDrawablesWithIntrinsicBounds(
                    drawables[0],
                    drawables[1],
                    drawables[2],
                    ContextCompat.getDrawable(context, value)
                )
            }


        /**
         * Convert this Drawable to Bitmap representation. Should take care of every Drawable type
         */
        fun Drawable.toBitmap(): Bitmap {
            if (this is BitmapDrawable) {
                return bitmap
            }

            val bitmap = if (intrinsicWidth <= 0 || intrinsicHeight <= 0) {
                Bitmap.createBitmap(1, 1, Bitmap.Config.ARGB_8888)
            } else {
                Bitmap.createBitmap(intrinsicWidth, intrinsicHeight, Bitmap.Config.ARGB_8888)
            }

            Canvas(bitmap).apply {
                setBounds(0, 0, width, height)
                draw(this)
            }
            return bitmap
        }


        fun View.fakeTouch() {
            val downTime = SystemClock.uptimeMillis()
            val eventTime = SystemClock.uptimeMillis() + 100
            val x = 0.0f
            val y = 0.0f
            val metaState = 0
            val motionEvent = MotionEvent.obtain(
                downTime,
                eventTime,
                MotionEvent.ACTION_UP,
                x,
                y,
                metaState
            )
            dispatchTouchEvent(motionEvent)
            motionEvent.recycle()
        }


        fun View.doOnApplyWindowInsets(
            f: (View, insets: WindowInsetsCompat, initialPadding: ViewDimensions, initialMargin: ViewDimensions) -> Unit
        ) {
            // Create a snapshot of the view's padding state
            val initialPadding = createStateForViewPadding(this)
            val initialMargin = createStateForViewMargin(this)
            ViewCompat.setOnApplyWindowInsetsListener(this) { v, insets ->
                f(v, insets, initialPadding, initialMargin)
                insets
            }
            requestApplyInsetsWhenAttached()
        }

        /**
         * Call [View.requestApplyInsets] in a safe away. If we're attached it calls it straight-away.
         * If not it sets an [View.OnAttachStateChangeListener] and waits to be attached before calling
         * [View.requestApplyInsets].
         */
        fun View.requestApplyInsetsWhenAttached() {
            if (isAttachedToWindow) {
                requestApplyInsets()
            } else {
                addOnAttachStateChangeListener(object : View.OnAttachStateChangeListener {
                    override fun onViewAttachedToWindow(v: View) {
                        v.requestApplyInsets()
                    }

                    override fun onViewDetachedFromWindow(v: View) = Unit
                })
            }
        }


        private fun createStateForViewPadding(view: View) = ViewDimensions(
            view.paddingLeft,
            view.paddingTop,
            view.paddingRight,
            view.paddingBottom,
            view.paddingStart,
            view.paddingEnd
        )

        private fun createStateForViewMargin(view: View): ViewDimensions {
            return (view.layoutParams as? ViewGroup.MarginLayoutParams)?.let {
                ViewDimensions(
                    it.leftMargin, it.topMargin, it.rightMargin, it.bottomMargin,
                    it.marginStart, it.marginEnd
                )
            } ?: ViewDimensions()
        }

        data class ViewDimensions(
            val left: Int = 0,
            val top: Int = 0,
            val right: Int = 0,
            val bottom: Int = 0,
            val start: Int = 0,
            val end: Int = 0
        )

        fun View.isRtl() = layoutDirection == View.LAYOUT_DIRECTION_RTL

        fun PopupMenu.hideItem(@IdRes res: Int, hide: Boolean = true) {
            menu.findItem(res).isVisible = !hide
        }

        fun android.widget.PopupMenu.hideItem(@IdRes res: Int, hide: Boolean = true) {
            menu.findItem(res).isVisible = !hide
        }


        @TargetApi(value = Build.VERSION_CODES.M)
        fun View.resetForeground() {
            if (canUseForeground) {
                foreground = null
            }
        }

        /**
         * Reads the file attributes safely
         * @receiver View
         * @param attrs AttributeSet?
         * @param styleableArray IntArray
         * @param block [@kotlin.ExtensionFunctionType] Function1<TypedArray, Unit>
         */
        inline fun View.readAttributes(
            attrs: AttributeSet?,
            styleableArray: IntArray,
            crossinline block: TypedArray.() -> Unit
        ) {
            val typedArray = context.theme.obtainStyledAttributes(attrs, styleableArray, 0, 0)
            typedArray.use {
                it.block()
            }  // From androidx.core
        }


        fun View.resetBackground() {
            setBackgroundResource(selectableItemBackgroundResource)
        }


        fun View.unsetRippleClickAnimation() =
            if (canUseForeground) resetForeground() else resetBackground()


        private val canUseForeground
            get() = Build.VERSION.SDK_INT >= Build.VERSION_CODES.M


        fun View.visibleIfTrueGoneOtherwise(condition: Boolean) {
            if (condition) {
                visible()
            } else {
                gone()
            }
        }

        fun View.goneIfTrueVisibleOtherwise(condition: () -> Boolean) {
            if (condition()) {
                gone()
            } else {
                visible()
            }
        }

        /**
         * Animates the view to rotate, can be refactored for more abstraction if needed
         *
         * @param rotation Value of rotation to be applied to view
         * @param duration Duration in millis of the rotation animation
         */
        fun View.rotateAnimation(rotation: Float, duration: Long) {
            val interpolator = OvershootInterpolator()
            isActivated = if (!isActivated) {
                ViewCompat.animate(this).rotation(rotation).withLayer().setDuration(duration)
                    .setInterpolator(interpolator).start()
                !isActivated
            } else {
                ViewCompat.animate(this).rotation(0f).withLayer().setDuration(duration)
                    .setInterpolator(interpolator).start()
                !isActivated
            }
        }

        fun View.blink(duration: Long = 300L) {
            val anim = AlphaAnimation(0.3f, 1.0f)
            anim.duration = duration
            startAnimation(anim)
        }

        /**
         * Returns the innermost focused child within this [View] hierarchy, or null if this is not a [ViewGroup]
         */
        val View.innermostFocusedChild: View?
            get() {
                if (this !is ViewGroup) return null
                val focused = focusedChild
                return focused?.innermostFocusedChild ?: focused
            }


        fun View.visibilityChangeListener(onVisibility: (isVisible: Boolean) -> Unit) {
            viewTreeObserver.addOnGlobalLayoutListener {
                onVisibility(isVisible)
            }
        }


        fun AppBarLayout.disableDragging() {
            val layoutParams = layoutParams as CoordinatorLayout.LayoutParams
            val behavior = layoutParams.behavior as AppBarLayout.Behavior?
            if (behavior != null) {
                behavior.setDragCallback(DisabledDragCallback)
            } else {
                doOnLayout {
                    (layoutParams.behavior as AppBarLayout.Behavior).setDragCallback(
                        DisabledDragCallback
                    )
                }
            }
        }

        fun AppBarLayout.invalidateScrollRanges() {
            invalidateScrollRangesMethod(this)
        }

        inline fun TabLayout.doOnTabReselected(crossinline action: (TabLayout.Tab) -> Unit) {
            addOnTabSelectedListener(object : TabLayout.OnTabSelectedListener {
                override fun onTabSelected(tab: TabLayout.Tab) {
                }

                override fun onTabUnselected(tab: TabLayout.Tab) {
                }

                override fun onTabReselected(tab: TabLayout.Tab) {
                    action(tab)
                }
            })
        }

        inline fun TabLayout.doOnTabSelected(crossinline action: (TabLayout.Tab) -> Unit) {
            addOnTabSelectedListener(object : TabLayout.OnTabSelectedListener {
                override fun onTabSelected(tab: TabLayout.Tab) {
                    action(tab)

                }

                override fun onTabUnselected(tab: TabLayout.Tab) {
                }

                override fun onTabReselected(tab: TabLayout.Tab) {
                }
            })
        }


        inline fun TabLayout.doOnTabUnSelected(crossinline action: (TabLayout.Tab) -> Unit) {
            addOnTabSelectedListener(object : TabLayout.OnTabSelectedListener {
                override fun onTabSelected(tab: TabLayout.Tab) {
                }

                override fun onTabUnselected(tab: TabLayout.Tab) {
                    action(tab)
                }

                override fun onTabReselected(tab: TabLayout.Tab) {
                }
            })
        }


        inline fun <reified T : ViewParent> View.findParentOfType(): T? {
            return findParentOfType(T::class.java)
        }

        fun <T : ViewParent> View.findParentOfType(type: Class<T>): T? {
            var p = parent
            while (p != null) {
                if (type.isInstance(p)) {
                    return type.cast(p)
                }
                p = p.parent
            }
            return null
        }


        fun Toolbar.setTitleOnClickListener(onClickListener: View.OnClickListener) {
            var titleView = toolbarTitleField.get(this) as View?
            if (titleView == null) {
                val title = title
                this.title = " " // Force Toolbar to create mTitleTextView
                this.title = title
                titleView = toolbarTitleField.get(this) as View
            }
            titleView.setOnClickListener(onClickListener)
        }

        fun Toolbar.setSubtitleOnClickListener(onClickListener: View.OnClickListener) {
            var subtitleView = toolbarSubtitleField.get(this) as View?
            if (subtitleView == null) {
                val subtitle = subtitle
                this.subtitle = " " // Force Toolbar to create mSubtitleTextView
                this.subtitle = subtitle
                subtitleView = toolbarSubtitleField.get(this) as View
            }
            subtitleView.setOnClickListener(onClickListener)
        }

        inline fun <reified T : CoordinatorLayout.Behavior<*>> View.getLayoutBehavior(): T {
            val layoutParams = layoutParams as CoordinatorLayout.LayoutParams
            return layoutParams.behavior as T
        }

        private val toolbarTitleField: Field by lazy(LazyThreadSafetyMode.NONE) {
            Toolbar::class.java.getDeclaredField("mTitleTextView").apply { isAccessible = true }
        }

        private val toolbarSubtitleField: Field by lazy(LazyThreadSafetyMode.NONE) {
            Toolbar::class.java.getDeclaredField("mSubtitleTextView").apply { isAccessible = true }
        }


        private object DisabledDragCallback : AppBarLayout.Behavior.DragCallback() {
            override fun canDrag(appBarLayout: AppBarLayout): Boolean = false
        }

        private val invalidateScrollRangesMethod: Method by lazy(LazyThreadSafetyMode.NONE) {
            AppBarLayout::class.java.getDeclaredMethod("invalidateScrollRanges")
                .apply { isAccessible = true }
        }

        fun TabLayout.addMarginInTabLayout(
            color: Int,
            width: Int,
            height: Int,
            paddingFromDivider: Int
        ) {
            val linearLayout = getChildAt(0) as LinearLayout
            linearLayout.showDividers = LinearLayout.SHOW_DIVIDER_MIDDLE
            val drawable = GradientDrawable()
            drawable.setColor(color)
            drawable.setSize(width, height)
            linearLayout.dividerPadding = paddingFromDivider
            linearLayout.dividerDrawable = drawable
        }

        fun View.forceScrollGestures() {
            setOnTouchListener { v, event ->
                when (event.action) {
                    MotionEvent.ACTION_DOWN ->
                        // Disallow ScrollView to intercept touch events.
                        v.parent.requestDisallowInterceptTouchEvent(true)

                    MotionEvent.ACTION_UP ->
                        // Allow ScrollView to intercept touch events.
                        v.parent.requestDisallowInterceptTouchEvent(false)
                }

                v.onTouchEvent(event)
                true
            }
        }

        fun SeekBar.updateGestureExclusion() {
            val gestureExclusionRects = mutableListOf<Rect>()

            // Skip this call if we're not running on Android 10+
            if (Build.VERSION.SDK_INT < 29) return

            // First, lets clear out any existing rectangles
            gestureExclusionRects.clear()

            // Now lets work out which areas should be excluded. For a SeekBar this will
            // be the bounds of the thumb drawable.

            thumb?.also { t ->
                gestureExclusionRects += t.copyBounds()
            }

            // If we had other elements in this view near the edges, we could exclude them
            // here too, by adding their bounds to the list

            // Finally pass our updated list of rectangles to the system
            systemGestureExclusionRects = gestureExclusionRects
        }


        fun View.updateGestureExclusion(gestureExclusionRects: List<Rect>) {
            // Skip this call if we're not running on Android 10+
            if (Build.VERSION.SDK_INT < 29) return
            // Finally pass our updated list of rectangles to the system
            systemGestureExclusionRects = gestureExclusionRects
        }


        /**
         * Declare a variable
        private var gestureDetector: ScaleGestureDetector? = null

        override fun onTouchEvent(event: MotionEvent?): Boolean {
        gestureDetector?.onTouchEvent(event)
        return true
        }
         * @receiver View
         * @param scaleFactor Float
         * @return ScaleGestureDetector
         */
        fun View.pinchToZoom(scaleFactor: Float = 1.0f) =
            ScaleGestureDetector(context, ScaleListener(scaleFactor, this))

        fun View?.removeSelf() {
            this ?: return
            val parentView = parent as? ViewGroup ?: return
            parentView.removeView(this)
        }

        /** Pad this view with the insets provided by the device cutout (i.e. notch) */
        @RequiresApi(Build.VERSION_CODES.P)
        fun View.padWithDisplayCutout() {

            /** Helper method that applies padding from cutout's safe insets */
            fun doPadding(cutout: DisplayCutout) = setPadding(
                cutout.safeInsetLeft,
                cutout.safeInsetTop,
                cutout.safeInsetRight,
                cutout.safeInsetBottom
            )

            // Apply padding using the display cutout designated "safe area"
            rootWindowInsets?.displayCutout?.let { doPadding(it) }

            // Set a listener for window insets since view.rootWindowInsets may not be ready yet
            setOnApplyWindowInsetsListener { _, insets ->
                insets.displayCutout?.let { doPadding(it) }
                insets
            }
        }


        inline fun View.ifVisible(action: () -> Unit) {
            if (isVisible) action()
        }


        inline fun View.ifInvisible(action: () -> Unit) {
            if (isInvisible) action()
        }


        inline fun View.ifGone(action: () -> Unit) {
            if (isGone) action()
        }


        private val tmpIntArr = IntArray(2)

        /**
         * Function which updates the given [rect] with this view's position and bounds in its window.
         */
        fun View.copyBoundsInWindow(rect: Rect) {
            if (isLaidOut && isAttachedToWindow) {
                rect.set(0, 0, width, height)
                getLocationInWindow(tmpIntArr)
                rect.offset(tmpIntArr[0], tmpIntArr[1])
            } else {
                throw IllegalArgumentException(
                    "Can not copy bounds as view is not laid out" +
                            " or attached to window"
                )
            }
        }


        /**
         * Hides all the views passed in the arguments
         */
        fun hideViews(vararg views: View) = views.asSequence().forEach { it.visibility = View.GONE }

        /**
         * Shows all the views passed in the arguments
         */
        fun showViews(vararg views: View) =
            views.asSequence().forEach { it.visibility = View.VISIBLE }


//        val View.isAppearanceLightNavigationBars
//            get() =
//                ViewCompat.getWindowInsetsController(this)?.isAppearanceLightNavigationBars
//
//        val View.isAppearanceLightStatusBars
//            get() =
//                ViewCompat.getWindowInsetsController(this)?.isAppearanceLightStatusBars

        fun View.createCircularReveal(
            revealDuration: Long = 1500L,
            centerX: Int = 0,
            centerY: Int = 0,
            @ColorRes startColor: Int,
            @ColorRes endColor: Int,
            showAtEnd: Boolean = true
        ): Animator {

            val radius = max(width, height).toFloat()
            val startRadius = if (showAtEnd) 0f else radius
            val finalRadius = if (showAtEnd) radius else 0f

            val animator =
                ViewAnimationUtils.createCircularReveal(
                    this,
                    centerX,
                    centerY,
                    startRadius,
                    finalRadius
                ).apply {
                    interpolator = FastOutSlowInInterpolator()
                    duration = revealDuration
                    doOnEnd {
                        isVisible = showAtEnd
                    }
                    start()
                }


            ValueAnimator().apply {
                setIntValues(
                    ContextCompat.getColor(context, startColor),
                    ContextCompat.getColor(context, endColor)
                )
                setEvaluator(ArgbEvaluatorCompat())
                addUpdateListener { valueAnimator -> setBackgroundColor((valueAnimator.animatedValue as Int)) }
                duration = revealDuration

                start()
            }
            return animator
        }

        fun View.accessibleTouchTarget() {
            post {
                val delegateArea = Rect()
                getHitRect(delegateArea)

                // 48 dp is the minimum requirement. We need to convert this to pixels.
                val accessibilityMin = context.dpToPx(48)

                // Calculate size vertically, and adjust touch area if it's smaller then the minimum.
                val height = delegateArea.bottom - delegateArea.top
                if (accessibilityMin > height) {
                    // Add +1 px just in case min - height is odd and will be rounded down
                    val addition = ((accessibilityMin - height) / 2).toInt() + 1
                    delegateArea.top -= addition
                    delegateArea.bottom += addition
                }

                // Calculate size horizontally, and adjust touch area if it's smaller then the minimum.
                val width = delegateArea.right - delegateArea.left
                if (accessibilityMin > width) {
                    // Add +1 px just in case min - width is odd and will be rounded down
                    val addition = ((accessibilityMin - width) / 2).toInt() + 1
                    delegateArea.left -= addition
                    delegateArea.right += addition
                }

                val parentView = parent as? View
                parentView?.touchDelegate = TouchDelegate(delegateArea, this)
            }
        }

        fun Context.dpToPx(value: Int) = TypedValue.applyDimension(
            TypedValue.COMPLEX_UNIT_DIP,
            value.toFloat(),
            resources.displayMetrics
        )


        fun View.xAnimator(
            values: FloatArray,
            duration: Long = 300,
            repeatCount: Int = 0,
            repeatMode: Int = 0
        ): Animator {
            val animator = ObjectAnimator.ofFloat(this, View.X, *values)
            animator.repeatCount = repeatCount
            animator.duration = duration
            if (repeatMode == ObjectAnimator.REVERSE || repeatMode == ObjectAnimator.RESTART) {
                animator.repeatMode = repeatMode
            }
            return animator
        }

        fun View.yAnimator(
            values: FloatArray,
            duration: Long = 300,
            repeatCount: Int = 0,
            repeatMode: Int = 0
        ): Animator {
            val animator = ObjectAnimator.ofFloat(this, View.Y, *values)
            animator.repeatCount = repeatCount
            animator.duration = duration
            if (repeatMode == ObjectAnimator.REVERSE || repeatMode == ObjectAnimator.RESTART) {
                animator.repeatMode = repeatMode
            }
            return animator
        }


        fun View.zAnimator(
            values: FloatArray,
            duration: Long = 300,
            repeatCount: Int = 0,
            repeatMode: Int = 0
        ): Animator {
            val animator = ObjectAnimator.ofFloat(this, View.Z, *values)
            animator.repeatCount = repeatCount
            animator.duration = duration
            if (repeatMode == ObjectAnimator.REVERSE || repeatMode == ObjectAnimator.RESTART) {
                animator.repeatMode = repeatMode
            }
            return animator
        }


        fun ViewGroup.isEmpty() = childCount == 0

        fun ViewGroup.isNotEmpty() = !isEmpty()

        /**
         * get Activity On Which View is inflated to
         */
        fun View.getActivity(): Activity? {
            if (context is Activity)
                return context as Activity
            return null
        }

        /**
         * will show the view If Condition is true else make if INVISIBLE or GONE Based on the [makeInvisible] flag
         */
        fun View.showIf(boolean: Boolean, makeInvisible: Boolean = false) {
            visibility =
                if (boolean) View.VISIBLE else if (makeInvisible) View.INVISIBLE else View.GONE
        }


        /**
         * will enable the view If Condition is true else enables It
         */

        fun View.enableIf(boolean: Boolean) = { isEnabled = boolean }

        /**
         * will disable the view If Condition is true else enables It
         */

        fun View.disableIf(boolean: Boolean) = { isEnabled = boolean.not() }

        val unspecified
            get() = View.MeasureSpec.UNSPECIFIED

        val atMost
            get() = View.MeasureSpec.AT_MOST

        val exactly
            get() = View.MeasureSpec.EXACTLY


        private fun Context.getResourceIdAttribute(@AttrRes attribute: Int): Int {
            val typedValue = TypedValue()
            theme.resolveAttribute(attribute, typedValue, true)
            theme.resolveAttribute(attribute, typedValue, true)
            return typedValue.resourceId
        }


        var View.transitionNameCompat: String?
            get() = ViewCompat.getTransitionName(this)
            set(value) = ViewCompat.setTransitionName(this, value)


        @TargetApi(value = Build.VERSION_CODES.M)
        fun View.setRippleClickForeground() {
            if (canUseForeground) {
                foreground = ContextCompat.getDrawable(
                    context,
                    context.getResourceIdAttribute(android.R.attr.selectableItemBackground)
                )
                setClickable()
            }
        }

        fun View.setRippleClickBackground() {
            setBackgroundResource(context.getResourceIdAttribute(android.R.attr.selectableItemBackground))
            setClickable()
        }

        fun View.setRippleClickAnimation() =
            if (canUseForeground) setRippleClickForeground() else setRippleClickBackground()


        private val canUseForegroundO
            get() = Build.VERSION.SDK_INT >= Build.VERSION_CODES.M


        fun View.setClickable() {
            isClickable = true
            isFocusable = true
        }


        fun View.setRoundRippleClickBackground() {
            setBackgroundResource(context.getResourceIdAttribute(android.R.attr.actionBarItemBackground))
            setClickable()
        }

        fun View.setRoundRippleClickAnimation() = setRoundRippleClickBackground()


        fun View.rootView(): View {
            var root = this
            while (root.parent is View) {
                root = root.parent as View
            }
            return root
        }


        fun View.resetFocus() {
            clearFocus()
            isFocusableInTouchMode = false
            isFocusable = false
            isFocusableInTouchMode = true
            isFocusable = true
        }

        inline fun <reified V : View> V.onFirstAttachToWindow(crossinline whenAttached: V.() -> Unit) {
            addOnAttachStateChangeListener(object : View.OnAttachStateChangeListener {
                override fun onViewDetachedFromWindow(v: View?) {
                    removeOnAttachStateChangeListener(this)
                }

                override fun onViewAttachedToWindow(v: View?) {
                    removeOnAttachStateChangeListener(this)
                    (v as? V)?.whenAttached()
                }
            })
        }

        inline fun <reified T : View> ViewGroup.findView(): T? {
            for (i in 0 until childCount) {
                val view = getChildAt(i)
                if (view is T) {
                    return view
                }
            }

            return null
        }

        var ViewGroup.animateLayoutChanges: Boolean
            set(value) {
                if (value) {
                    layoutTransition = LayoutTransition().apply {
                        disableTransitionType(LayoutTransition.DISAPPEARING)
                    }
                } else {
                    layoutTransition = null
                }
            }
            get() = layoutTransition != null


        fun View.setSize(height: Int, width: Int) {
            val params = layoutParams
            params.width = width
            params.height = height
            layoutParams = params
        }


        fun ViewGroup.getString(@StringRes stringRes: Int): String {
            return this.context.getString(stringRes)
        }


        fun View.setMargins(left: Int, top: Int, right: Int, bottom: Int) {
            val params = layoutParams


            when (params) {
                is ConstraintLayout.LayoutParams -> {
                    params.setMargins(left, top, right, bottom)
                    this.layoutParams = params
                }
                is LinearLayout.LayoutParams -> {
                    params.setMargins(left, top, right, bottom)
                    this.layoutParams = params
                }
                is FrameLayout.LayoutParams -> {
                    params.setMargins(left, top, right, bottom)
                    this.layoutParams = params
                }
                is RelativeLayout.LayoutParams -> {
                    params.setMargins(left, top, right, bottom)
                    this.layoutParams = params
                }
            }
        }

        fun View.modifyMargin(
            left: Int? = null,
            top: Int? = null,
            right: Int? = null,
            bottom: Int? = null
        ) {
            val l = left ?: this.marginLeft
            val t = top ?: this.marginTop
            val r = right ?: this.marginRight
            val b = bottom ?: this.marginBottom
            this.setMargins(l, t, r, b)
        }

        fun View.modifyPadding(
            left: Int? = null,
            top: Int? = null,
            right: Int? = null,
            bottom: Int? = null
        ) {
            val l = left ?: this.paddingLeft
            val t = top ?: this.paddingTop
            val r = right ?: this.paddingRight
            val b = bottom ?: this.paddingBottom
            this.setPadding(l, t, r, b)
        }


        fun View.scale(scale: Float) {
            this.scaleX = scale
            this.scaleY = scale
        }

        fun View.setWidthWrapContent() {
            val params = this.layoutParams
            params.width = ViewGroup.LayoutParams.WRAP_CONTENT
            this.layoutParams = params
        }

        fun View.setHeightWrapContent() {
            val params = this.layoutParams
            params.height = ViewGroup.LayoutParams.WRAP_CONTENT
            this.layoutParams = params
        }

        fun View.disableClipOnParents() {
            val v = this

            if (v.parent == null) {
                return
            }

            if (v is ViewGroup) {
                v.clipChildren = false
            }

            if (v.parent is View) {
                (v.parent as View).disableClipOnParents()
            }
        }

        fun View.getGoneHeight(): Int {
            val widthSpec = View.MeasureSpec.makeMeasureSpec(this.width, View.MeasureSpec.EXACTLY)
            val heightSpec = View.MeasureSpec.makeMeasureSpec(0, View.MeasureSpec.UNSPECIFIED)
            this.measure(widthSpec, heightSpec)
            return this.measuredHeight
        }

        fun View.setSemiTransparentIf(shouldBeTransparent: Boolean, disabledAlpha: Float = 0.3f) {
            alpha = when (shouldBeTransparent) {
                true -> disabledAlpha
                false -> 1f
            }
        }

        fun ViewGroup.subviews(vararg views: View): View {
            assignViewIdIfNeeded()
            for (v in views) {
                v.assignViewIdIfNeeded()
                addView(v)
            }
            return this
        }

        fun View.assignViewIdIfNeeded() {
            if (id == -1) {
                id = View.generateViewId()
            }
        }

        fun View.getGoneHeight(callback: (futureHeight: Int) -> Unit) {


            afterLatestMeasured {
                val originalHeight =
                    height // save the original height (is most likely wrap content)

                setHeight(0) // "hide" the view
                invisible() // make the view invisible so it gets a width

                this.afterLatestMeasured {

                    val originalWidth = width // the view now has a width

                    // measure how high the view will be
                    val widthSpec =
                        View.MeasureSpec.makeMeasureSpec(originalWidth, View.MeasureSpec.EXACTLY)
                    val heightSpec =
                        View.MeasureSpec.makeMeasureSpec(0, View.MeasureSpec.UNSPECIFIED)
                    measure(widthSpec, heightSpec)

                    val futureHeight = measuredHeight

                    // hide the view and set back to the original height
                    gone()
                    setHeight(originalHeight)
                    callback(futureHeight)
                }
            }
        }


        fun layout(vararg items: Any) {
            var previousMargin: Int? = null
            var previousView: View? = null
            var viewCount = 0
            for (item in items) {

                fun layoutView(view: View) {
                    previousMargin?.let { previousMargin ->
                        if (viewCount == 1) {
                            view.top(previousMargin)
                        } else {
                            previousView?.let { previousView ->
                                view.constrainTopToBottomOf(previousView, previousMargin)
                            }
                        }
                    }
                    previousView = view
                }

                // Embedded Horizontal layout.
                (item as? Array<Any>)?.let { horizontalLayout ->

                    // Take first "View" type in the array to layout.
                    var secondItem = if (horizontalLayout.count() > 1) horizontalLayout[1] else null
                    var firstView = (horizontalLayout.firstOrNull() as? View)
                        ?: (secondItem as? View)
                    firstView?.let {
                        layoutView(it)
                    }
                }

                when (item) {
                    is Int -> {
                        previousMargin = item
                        if (viewCount == items.count() - 1) { // Last Margin == Bottom
                            previousView?.let { previousView ->
                                previousView.bottom(item)
                            }
                        }
                    }
                    is View -> {
                        layoutView(item)
                    }
                    is String -> {
                        previousMargin = null
                        previousView = null
                    }
                }
                viewCount++
            }
        }


        /**
         *  Request to be laid out fullscreen tell the system to lay out our app behind the system bars
         */
        fun View.fullScreen() {
            systemUiVisibility =
                    // Tells the system that the window wishes the content to
                    // be laid out at the most extreme scenario. See the docs for
                    // more information on the specifics
                View.SYSTEM_UI_FLAG_LAYOUT_STABLE or
                        // Tells the system that the window wishes the content to
                        // be laid out as if the navigation bar was hidden
                        View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION or
                        View.SYSTEM_UI_FLAG_FULLSCREEN
        }


        fun View.dip(value: Int): Int = (value * (resources.displayMetrics.density)).toInt()
        fun View.dimen(@DimenRes resourceId: Int): Float = resources.getDimension(resourceId)
        fun View.integer(@IntegerRes resourceId: Int): Int = resources.getInteger(resourceId)
        fun View.bool(@BoolRes resourceId: Int): Boolean = resources.getBoolean(resourceId)
        fun View.colorStateList(@ColorRes resourceId: Int): ColorStateList? =
            ContextCompat.getColorStateList(context, resourceId)

        fun View.drawable(@DrawableRes resourceId: Int): Drawable? =
            ContextCompat.getDrawable(context, resourceId)

        fun View.drawable(@DrawableRes resourceId: Int, tintColorResId: Int): Drawable? =
            ContextCompat.getDrawable(context, resourceId)?.apply {
                setTint(color(tintColorResId))
            }


        fun View.string(@StringRes resourceId: Int): String = resources.getString(resourceId)
        fun View.string(@StringRes resourceId: Int, vararg args: Any?): String =
            resources.getString(resourceId, *args)

        fun View.quantityString(
            @PluralsRes resourceId: Int,
            quantity: Int,
            vararg args: Any?
        ): String = resources.getQuantityString(resourceId, quantity, quantity, *args)


        fun View.snack(
            msg: CharSequence, @ColorRes colorResId: Int? = null,
            duration: Int = Snackbar.LENGTH_SHORT, build: (Snackbar.() -> Unit)? = null
        ) {
            val snackbar = Snackbar.make(this, msg, duration)
            colorResId?.let { snackbar.view.setBackgroundColor(color(colorResId)) }
            build?.let { snackbar.build() }
            snackbar.show()
        }

        val View.window: Window
            get() = activity.window


        val View.activity: ComponentActivity
            get() = context as ComponentActivity


        fun View.setNewHeight(value: Int) {
            val lp = layoutParams
            lp?.let {
                lp.height = value
                layoutParams = lp
            }
        }

        fun View.setNewWidth(value: Int) {
            val lp = layoutParams
            lp?.let {
                lp.width = value
                layoutParams = lp
            }
        }


        inline var View.bottomMargin: Int
            get():Int {
                return (layoutParams as ViewGroup.MarginLayoutParams).bottomMargin
            }
            set(value) {
                (layoutParams as ViewGroup.MarginLayoutParams).bottomMargin = value
            }

        inline var View.topMargin: Int
            get():Int {
                return (layoutParams as ViewGroup.MarginLayoutParams).topMargin
            }
            set(value) {
                (layoutParams as ViewGroup.MarginLayoutParams).topMargin = value
            }

        inline var View.rightMargin: Int
            get():Int {
                return (layoutParams as ViewGroup.MarginLayoutParams).rightMargin
            }
            set(value) {
                (layoutParams as ViewGroup.MarginLayoutParams).rightMargin = value
            }

        inline var View.leftMargin: Int
            get():Int {
                return (layoutParams as ViewGroup.MarginLayoutParams).leftMargin
            }
            set(value) {
                (layoutParams as ViewGroup.MarginLayoutParams).leftMargin = value
            }

        fun View.setMargin(left: Int, top: Int, right: Int, bottom: Int) {
            (layoutParams as ViewGroup.MarginLayoutParams).setMargins(left, top, right, bottom)
        }

        inline var View.leftPadding: Int
            get() = paddingLeft
            set(value) = setPadding(value, paddingTop, paddingRight, paddingBottom)

        inline var View.topPadding: Int
            get() = paddingTop
            set(value) = setPadding(paddingLeft, value, paddingRight, paddingBottom)

        inline var View.rightPadding: Int
            get() = paddingRight
            set(value) = setPadding(paddingLeft, paddingTop, value, paddingBottom)

        inline var View.bottomPadding: Int
            get() = paddingBottom
            set(value) = setPadding(paddingLeft, paddingTop, paddingRight, value)


        fun List<View>.gone() {
            this.forEach { it.gone() }
        }

        fun List<View>.invisible() {
            this.forEach { it.invisible() }
        }

        fun List<View>.visible() {
            this.forEach { it.visible() }
        }


        fun SearchView.textListener(
            onQuerySubmit: (queryTextSubmit: String) -> Unit = { _ -> },
            onQueryChange: (queryTextChange: String) -> Unit = { _ -> }
        ) {
            this.setOnQueryTextListener(object : SearchView.OnQueryTextListener {
                override fun onQueryTextSubmit(query: String?): Boolean {
                    onQuerySubmit(query.toString())
                    return true
                }

                override fun onQueryTextChange(query: String?): Boolean {
                    onQueryChange(query.toString())
                    return true
                }
            })
        }

        val SearchView?.getSubmitButton get() = this?.findViewById<ImageView>(androidx.appcompat.R.id.search_go_btn)
        val SearchView?.getCloseButton get() = this?.findViewById<ImageView>(androidx.appcompat.R.id.search_close_btn)
        val SearchView?.getVoiceButton get() = this?.findViewById<ImageView>(androidx.appcompat.R.id.search_voice_btn)
        val SearchView?.getCollapsedIcon get() = this?.findViewById<ImageView>(androidx.appcompat.R.id.search_mag_icon)


        fun BottomSheetBehavior<*>.sliderListener(
            onSlide: (bottomSheet: View, slideOffset: Float) -> Unit = { _, _ -> },
            onStateChanged: (bottomSheet: View, newState: Int) -> Unit = { _, _ -> }
        ) {


            this.addBottomSheetCallback(object : BottomSheetBehavior.BottomSheetCallback() {
                override fun onSlide(bottomSheet: View, slideOffset: Float) {
                    onSlide(bottomSheet, slideOffset)
                }


                override fun onStateChanged(bottomSheet: View, newState: Int) {
                    onStateChanged(bottomSheet, newState)
                }
            })

        }

        fun View.enable() {
            this.isEnabled = true
        }

        fun View.toggleEnabled() {
            this.isEnabled = !this.isEnabled
        }

        fun View.disable() {
            this.isEnabled = false
        }

        fun View.toggleSelected() {
            this.isSelected = !this.isSelected
        }

        fun View.windowBackground(): Int {
            return context.themeAttributeToColor(android.R.attr.windowBackground)
        }

        // Used to tint buttons
        fun Context.textColorTertiary(): Int {
            return this.themeAttributeToColor(android.R.attr.textColorTertiary)
        }

        fun MenuItem.disable() {
            this.isEnabled = false
        }

        fun MenuItem.enable() {
            this.isEnabled = true
        }

        fun MenuItem.toggleEnabled() {
            this.isEnabled = !this.isEnabled
        }

        fun MenuItem.check() {
            this.isChecked = true
        }

        fun MenuItem.unCheck() {
            this.isChecked = false
        }

        fun MenuItem.toggleChecked() {
            this.isChecked = !this.isChecked
        }

        fun Context.themeAttributeToColor(
            themeAttributeId: Int,
            fallbackColor: Int = Color.WHITE
        ): Int {
            val outValue = TypedValue()
            val theme = this.theme
            val resolved = theme.resolveAttribute(themeAttributeId, outValue, true)
            if (resolved) {
                return ContextCompat.getColor(this, outValue.resourceId)
            }
            return fallbackColor
        }

        fun SeekBar.onProgressChanged(callback: (theSeekBar: SeekBar, progress: Int, fromUser: Boolean) -> Unit) {
            setOnSeekBarChangeListener(object : SeekBar.OnSeekBarChangeListener {
                override fun onStopTrackingTouch(seekBar: SeekBar) = Unit

                override fun onStartTrackingTouch(seekBar: SeekBar?) = Unit

                override fun onProgressChanged(seekBar: SeekBar, progress: Int, fromUser: Boolean) =
                    callback(seekBar, progress, fromUser)
            })
        }


        fun CompoundButton.onChecked(onChecked: (View, Boolean) -> Unit) {
            setOnCheckedChangeListener { buttonView, isChecked ->
                onChecked(buttonView, isChecked)
            }
        }

        fun View.dismissKeyboard() {
            val imm = context.getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager
            imm.hideSoftInputFromWindow(windowToken, 0)
        }


        fun View.snackbar(
            message: Int, duration: Int = Snackbar.LENGTH_SHORT,
            actionName: Int = 0, actionTextColor: Int = 0, action: (View) -> Unit = {}
        ): Snackbar {
            val snackbar = Snackbar.make(this, message, duration)

            if (actionName != 0 && action != {}) snackbar.setAction(actionName, action)
            if (actionTextColor != 0) snackbar.setActionTextColor(actionTextColor)

            snackbar.show()
            return snackbar
        }

        fun View.snackbar(
            message: Int, duration: Int = Snackbar.LENGTH_SHORT,
            actionName: String = "", actionTextColor: Int = 0, action: (View) -> Unit = {}
        ): Snackbar {
            val snackbar = Snackbar.make(this, message, duration)

            if (actionName != "" && action != {}) snackbar.setAction(actionName, action)
            if (actionTextColor != 0) snackbar.setActionTextColor(actionTextColor)

            snackbar.show()
            return snackbar
        }

        fun View.snackbar(
            message: String, duration: Int = Snackbar.LENGTH_SHORT,
            actionName: Int = 0, actionTextColor: Int = 0, action: (View) -> Unit = {}
        ): Snackbar {
            val snackbar = Snackbar.make(this, message, duration)

            if (actionName != 0 && action != {}) snackbar.setAction(actionName, action)
            if (actionTextColor != 0) snackbar.setActionTextColor(actionTextColor)

            snackbar.show()
            return snackbar
        }

        fun View.snackbar(
            message: String, duration: Int = Snackbar.LENGTH_SHORT,
            actionName: String = "", actionTextColor: Int = 0, action: (View) -> Unit = {}
        ): Snackbar {
            val snackbar = Snackbar.make(this, message, duration)

            if (actionName != "" && action != {}) snackbar.setAction(actionName, action)
            if (actionTextColor != 0) snackbar.setActionTextColor(actionTextColor)

            snackbar.show()
            return snackbar
        }

        fun View.animateTranslationX(
            values: FloatArray,
            duration: Long = 300,
            repeatCount: Int = 0,
            repeatMode: Int = 0
        ) {
            val animator = ObjectAnimator.ofFloat(this, View.TRANSLATION_X, *values)
            animator.repeatCount = repeatCount
            animator.duration = duration
            if (repeatMode == ObjectAnimator.REVERSE || repeatMode == ObjectAnimator.RESTART) {
                animator.repeatMode = repeatMode
            }
            animator.start()
        }

        fun View.animateTranslationY(
            values: FloatArray,
            duration: Long = 300,
            repeatCount: Int = 0,
            repeatMode: Int = 0
        ) {
            val animator = ObjectAnimator.ofFloat(this, View.TRANSLATION_Y, *values)
            animator.repeatCount = repeatCount
            animator.duration = duration
            if (repeatMode == ObjectAnimator.REVERSE || repeatMode == ObjectAnimator.RESTART) {
                animator.repeatMode = repeatMode
            }
            animator.start()
        }


        fun View.animateTranslationZ(
            values: FloatArray,
            duration: Long = 300,
            repeatCount: Int = 0,
            repeatMode: Int = 0
        ) {
            val animator = ObjectAnimator.ofFloat(this, View.TRANSLATION_Z, *values)
            animator.repeatCount = repeatCount
            animator.duration = duration
            if (repeatMode == ObjectAnimator.REVERSE || repeatMode == ObjectAnimator.RESTART) {
                animator.repeatMode = repeatMode
            }
            animator.start()
        }

        fun View.animateScaleX(
            values: FloatArray,
            duration: Long = 300,
            repeatCount: Int = 0,
            repeatMode: Int = 0
        ) {
            val animator = ObjectAnimator.ofFloat(this, View.SCALE_X, *values)
            animator.repeatCount = repeatCount
            animator.duration = duration
            if (repeatMode == ObjectAnimator.REVERSE || repeatMode == ObjectAnimator.RESTART) {
                animator.repeatMode = repeatMode
            }
            animator.start()
        }

        fun View.animateScaleY(
            values: FloatArray,
            duration: Long = 300,
            repeatCount: Int = 0,
            repeatMode: Int = 0
        ) {
            val animator = ObjectAnimator.ofFloat(this, View.SCALE_Y, *values)
            animator.repeatCount = repeatCount
            animator.duration = duration
            if (repeatMode == ObjectAnimator.REVERSE || repeatMode == ObjectAnimator.RESTART) {
                animator.repeatMode = repeatMode
            }
            animator.start()
        }

        fun View.animateAlpha(
            values: FloatArray,
            duration: Long = 300,
            repeatCount: Int = 0,
            repeatMode: Int = 0
        ) {
            val animator = ObjectAnimator.ofFloat(this, View.ALPHA, *values)
            animator.repeatCount = repeatCount
            animator.duration = duration
            if (repeatMode == ObjectAnimator.REVERSE || repeatMode == ObjectAnimator.RESTART) {
                animator.repeatMode = repeatMode
            }
            animator.start()
        }

        fun View.animateRotation(
            values: FloatArray,
            duration: Long = 300,
            repeatCount: Int = 0,
            repeatMode: Int = 0
        ) {
            val animator = ObjectAnimator.ofFloat(this, View.ROTATION, *values)
            animator.repeatCount = repeatCount
            animator.duration = duration
            if (repeatMode == ObjectAnimator.REVERSE || repeatMode == ObjectAnimator.RESTART) {
                animator.repeatMode = repeatMode
            }
            animator.start()
        }

        fun View.animateRotationX(
            values: FloatArray,
            duration: Long = 300,
            repeatCount: Int = 0,
            repeatMode: Int = 0
        ) {
            val animator = ObjectAnimator.ofFloat(this, View.ROTATION_X, *values)
            animator.repeatCount = repeatCount
            animator.duration = duration
            if (repeatMode == ObjectAnimator.REVERSE || repeatMode == ObjectAnimator.RESTART) {
                animator.repeatMode = repeatMode
            }
            animator.start()
        }

        fun View.animateRotationY(
            values: FloatArray,
            duration: Long = 300,
            repeatCount: Int = 0,
            repeatMode: Int = 0
        ) {
            val animator = ObjectAnimator.ofFloat(this, View.ROTATION_Y, *values)
            animator.repeatCount = repeatCount
            animator.duration = duration
            if (repeatMode == ObjectAnimator.REVERSE || repeatMode == ObjectAnimator.RESTART) {
                animator.repeatMode = repeatMode
            }
            animator.start()
        }

        fun View.animateX(
            values: FloatArray,
            duration: Long = 300,
            repeatCount: Int = 0,
            repeatMode: Int = 0
        ) {
            val animator = ObjectAnimator.ofFloat(this, View.X, *values)
            animator.repeatCount = repeatCount
            animator.duration = duration
            if (repeatMode == ObjectAnimator.REVERSE || repeatMode == ObjectAnimator.RESTART) {
                animator.repeatMode = repeatMode
            }
            animator.start()
        }

        fun View.animateY(
            values: FloatArray,
            duration: Long = 300,
            repeatCount: Int = 0,
            repeatMode: Int = 0
        ) {
            val animator = ObjectAnimator.ofFloat(this, View.Y, *values)
            animator.repeatCount = repeatCount
            animator.duration = duration
            if (repeatMode == ObjectAnimator.REVERSE || repeatMode == ObjectAnimator.RESTART) {
                animator.repeatMode = repeatMode
            }
            animator.start()
        }


        fun View.animateZ(
            values: FloatArray,
            duration: Long = 300,
            repeatCount: Int = 0,
            repeatMode: Int = 0
        ) {
            val animator = ObjectAnimator.ofFloat(this, View.Z, *values)
            animator.repeatCount = repeatCount
            animator.duration = duration
            if (repeatMode == ObjectAnimator.REVERSE || repeatMode == ObjectAnimator.RESTART) {
                animator.repeatMode = repeatMode
            }
            animator.start()
        }

        fun View.translationXAnimator(
            values: FloatArray,
            duration: Long = 300,
            repeatCount: Int = 0,
            repeatMode: Int = 0
        ): Animator {
            val animator = ObjectAnimator.ofFloat(this, View.TRANSLATION_X, *values)
            animator.repeatCount = repeatCount
            animator.duration = duration
            if (repeatMode == ObjectAnimator.REVERSE || repeatMode == ObjectAnimator.RESTART) {
                animator.repeatMode = repeatMode
            }
            return animator
        }

        fun View.translationYAnimator(
            values: FloatArray,
            duration: Long = 300,
            repeatCount: Int = 0,
            repeatMode: Int = 0
        ): Animator {
            val animator = ObjectAnimator.ofFloat(this, View.TRANSLATION_Y, *values)
            animator.repeatCount = repeatCount
            animator.duration = duration
            if (repeatMode == ObjectAnimator.REVERSE || repeatMode == ObjectAnimator.RESTART) {
                animator.repeatMode = repeatMode
            }
            return animator
        }


        fun View.translationZAnimator(
            values: FloatArray,
            duration: Long = 300,
            repeatCount: Int = 0,
            repeatMode: Int = 0
        ): Animator {
            val animator = ObjectAnimator.ofFloat(this, View.TRANSLATION_Z, *values)
            animator.repeatCount = repeatCount
            animator.duration = duration
            if (repeatMode == ObjectAnimator.REVERSE || repeatMode == ObjectAnimator.RESTART) {
                animator.repeatMode = repeatMode
            }
            return animator
        }

        fun View.scaleXAnimator(
            values: FloatArray,
            duration: Long = 300,
            repeatCount: Int = 0,
            repeatMode: Int = 0
        ): Animator {
            val animator = ObjectAnimator.ofFloat(this, View.SCALE_X, *values)
            animator.repeatCount = repeatCount
            animator.duration = duration
            if (repeatMode == ObjectAnimator.REVERSE || repeatMode == ObjectAnimator.RESTART) {
                animator.repeatMode = repeatMode
            }
            return animator
        }

        fun View.scaleYAnimator(
            values: FloatArray,
            duration: Long = 300,
            repeatCount: Int = 0,
            repeatMode: Int = 0
        ): Animator {
            val animator = ObjectAnimator.ofFloat(this, View.SCALE_Y, *values)
            animator.repeatCount = repeatCount
            animator.duration = duration
            if (repeatMode == ObjectAnimator.REVERSE || repeatMode == ObjectAnimator.RESTART) {
                animator.repeatMode = repeatMode
            }
            return animator
        }

        fun View.alphaAnimator(
            values: FloatArray,
            duration: Long = 300,
            repeatCount: Int = 0,
            repeatMode: Int = 0
        ): Animator {
            val animator = ObjectAnimator.ofFloat(this, View.ALPHA, *values)
            animator.repeatCount = repeatCount
            animator.duration = duration
            if (repeatMode == ObjectAnimator.REVERSE || repeatMode == ObjectAnimator.RESTART) {
                animator.repeatMode = repeatMode
            }
            return animator
        }

        fun View.rotationAnimator(
            values: FloatArray,
            duration: Long = 300,
            repeatCount: Int = 0,
            repeatMode: Int = 0
        ): Animator {
            val animator = ObjectAnimator.ofFloat(this, View.ROTATION, *values)
            animator.repeatCount = repeatCount
            animator.duration = duration
            if (repeatMode == ObjectAnimator.REVERSE || repeatMode == ObjectAnimator.RESTART) {
                animator.repeatMode = repeatMode
            }
            return animator
        }

        fun View.rotationXAnimator(
            values: FloatArray,
            duration: Long = 300,
            repeatCount: Int = 0,
            repeatMode: Int = 0
        ): Animator {
            val animator = ObjectAnimator.ofFloat(this, View.ROTATION_X, *values)
            animator.repeatCount = repeatCount
            animator.duration = duration
            if (repeatMode == ObjectAnimator.REVERSE || repeatMode == ObjectAnimator.RESTART) {
                animator.repeatMode = repeatMode
            }
            return animator
        }

        fun View.rotationYAnimator(
            values: FloatArray,
            duration: Long = 300,
            repeatCount: Int = 0,
            repeatMode: Int = 0
        ): Animator {
            val animator = ObjectAnimator.ofFloat(this, View.ROTATION_Y, *values)
            animator.repeatCount = repeatCount
            animator.duration = duration
            if (repeatMode == ObjectAnimator.REVERSE || repeatMode == ObjectAnimator.RESTART) {
                animator.repeatMode = repeatMode
            }
            return animator
        }


        private const val DEFAULT_DRAWER_GRAVITY = GravityCompat.START

        val DrawerLayout?.isOpen: Boolean get() = this?.isDrawerOpen(GravityCompat.START) ?: false
        val DrawerLayout?.isEndOpen: Boolean get() = this?.isDrawerOpen(GravityCompat.END) ?: false
        fun DrawerLayout?.open() = this?.openDrawer(GravityCompat.START)
        fun DrawerLayout?.openEnd() = this?.openDrawer(GravityCompat.END)
        fun DrawerLayout?.close() = this?.closeDrawer(GravityCompat.START)
        fun DrawerLayout?.closeEnd() = this?.openDrawer(GravityCompat.END)
        fun DrawerLayout?.toggle() = if (isOpen) close() else open()
        fun DrawerLayout?.toggleEnd() = if (isEndOpen) closeEnd() else closeEnd()

        inline fun DrawerLayout.consume(
            gravity: Int = GravityCompat.START,
            func: () -> Unit
        ): Boolean {
            func()
            close()
            return true
        }

        fun View.setLightStatusBar(condition: Boolean = true) {
            if (Build.VERSION.SDK_INT >= 23 && condition) {
                systemUiVisibility = systemUiVisibility or View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR
            }
        }

        val Context.hasNavigationBar: Boolean
            get() {
                return !ViewConfiguration.get(this).hasPermanentMenuKey()
            }

        /**
         * Return true if navigation bar is at the bottom, false otherwise
         */
        val Context.isNavigationBarHorizontal: Boolean
            get() {
                if (!hasNavigationBar) return false
                val dm = resources.displayMetrics
                return !navigationBarCanChangeItsPosition || dm.widthPixels < dm.heightPixels
            }

        /**
         * Return true if navigation bar change its position when device rotates, false otherwise
         */
        val Context.navigationBarCanChangeItsPosition: Boolean // Only phone between 0-599dp can
            get() {
                val dm = resources.displayMetrics
                return dm.widthPixels != dm.heightPixels && resources.configuration.smallestScreenWidthDp < 600
            }

        /**
         * Return the status bar height. 0 otherwise
         */
        val Context.statusBarHeight: Int
            get() {
                val id = resources.getIdentifier("status_bar_height", "dimen", "android")
                return resources.getDimensionPixelSize(id)
            }

        inline fun <T : View> T.onClick(crossinline func: T.() -> Unit) {
            setOnClickListener { func() }
        }

        inline fun <T : View> T.onLongClick(crossinline func: T.() -> Unit) {
            setOnLongClickListener { func(); true }
        }

        inline fun <T : View> T.onGlobalLayout(crossinline func: T.() -> Unit) {
            viewTreeObserver.addOnGlobalLayoutListener(object :
                ViewTreeObserver.OnGlobalLayoutListener {
                override fun onGlobalLayout() {
                    if (measuredWidth > 0 && measuredHeight > 0) {
                        viewTreeObserver.removeOnGlobalLayoutListener(this)
                        func()
                    }
                }
            })
        }

        inline fun <T : View> T.onPreDraw(crossinline func: T.() -> Unit) {
            viewTreeObserver.addOnPreDrawListener(object : ViewTreeObserver.OnPreDrawListener {
                override fun onPreDraw(): Boolean {
                    viewTreeObserver.removeOnPreDrawListener(this)
                    func()
                    return true
                }
            })
        }


        fun View.changeBackgroundColor(@ColorInt newColor: Int, duration: Int = 300) {
            val oldBackground = background
            val color = ColorDrawable(newColor)
            val ld = LayerDrawable(arrayOf<Drawable>(color))
            if (oldBackground == null) background = ld
            else {
                val td = TransitionDrawable(arrayOf(oldBackground, ld))
                background = td
                td.startTransition(duration)
            }
        }


        inline fun Snackbar.maxLines(lines: Int): Snackbar {
            view.findViewById<TextView>(com.google.android.material.R.id.snackbar_text).maxLines = lines
            return this
        }


        /**
         * Sets receiver's visibility to [View.GONE] if [TextView.getText] is
         * null or empty; sets it to [View.VISIBLE] otherwise.
         */
        fun TextView.collapseIfEmpty() {
            visibility = if (!text.isNullOrEmpty()) View.VISIBLE else View.GONE
        }

        /**
         * Sets receiver's visibility to [View.INVISIBLE] if [TextView.getText] is
         * null or empty; sets it to [View.VISIBLE] otherwise.
         */
        fun TextView.hideIfEmpty() {
            visibility = if (!text.isNullOrEmpty()) View.VISIBLE else View.INVISIBLE
        }


        /**
         * Displays a popup by inflating menu with specified
         * [menu resource id][menuResourceId], calling [onClick] when an item
         * is clicked, and optionally calling [onInit] with
         * [PopupMenu] as receiver to initialize prior to display.
         */
        fun View.showPopup(
            @MenuRes menuResourceId: Int,
            onInit: android.widget.PopupMenu.() -> Unit = {},
            onClick: (MenuItem) -> Boolean
        ) {
            android.widget.PopupMenu(context, this).apply {
                menuInflater.inflate(menuResourceId, menu)
                onInit(this)
                setOnMenuItemClickListener(onClick)
            }.show()
        }

        /**
         * Sets receiver's visibility to [View.INVISIBLE] if [value] is true;
         * sets it to [View.VISIBLE] otherwise. Opposite of [showIf]; also
         * see [collapseIf].
         */
        fun View.hideIf(value: Boolean) {
            visibility = if (!value) View.VISIBLE else View.INVISIBLE
        }

        /**
         * Sets receiver's visibility to [View.GONE] if [value] is true;
         * sets it to [View.VISIBLE] otherwise. Opposite of [expandIf]; also
         * see [hideIf].
         */
        fun View.collapseIf(value: Boolean) {
            visibility = if (!value) View.VISIBLE else View.GONE
        }

        inline fun <T : Adapter> AdapterView<T>.onItemSelected(crossinline action: (parent: AdapterView<*>?, view: View?, position: Int, id: Long) -> Unit = { _, _, _, _ -> }) {
            onItemSelectedListener = object : AdapterView.OnItemSelectedListener {
                override fun onNothingSelected(parent: AdapterView<*>?) = Unit
                override fun onItemSelected(
                    parent: AdapterView<*>?,
                    view: View?,
                    position: Int,
                    id: Long
                ) =
                    action(parent, view, position, id)
            }
        }

        /**
         * Returns the default, clear background for selectable items.  Reacts when touched.
         */
        val View.selectableItemBackgroundResource: Int
            get() {
                val outValue = TypedValue()
                context.theme.resolveAttribute(
                    android.R.attr.selectableItemBackground,
                    outValue,
                    true
                )
                return outValue.resourceId
            }

        /**
         * Returns the default, clear background for selectable items without a border.  Reacts when touched.
         */
        val View.selectableItemBackgroundBorderlessResource: Int
            get() {
                val outValue = TypedValue()
                context.theme.resolveAttribute(
                    android.R.attr.selectableItemBackgroundBorderless,
                    outValue,
                    true
                )
                return outValue.resourceId
            }

        /**
         * Allows you to modify the elevation on a view without worrying about version.
         */
        var View.elevationCompat: Float
            get() {
                return elevation
            }
            set(value) {
                elevation = value
            }

        /**
         * Shows the soft input for the vindow.
         */
        fun View.showSoftInput() {
            context.getSystemService(Context.INPUT_METHOD_SERVICE).let { it as InputMethodManager }
                .showSoftInput(this, 0)
        }

        /**
         * Hides the soft input for the vindow.
         */
        fun View.hideSoftInput() {
            context.getSystemService(Context.INPUT_METHOD_SERVICE).let { it as InputMethodManager }
                .hideSoftInputFromWindow(this.applicationWindowToken, 0)
        }

        /**
         * Sets an on click listener for a view, but ensures the action cannot be triggered more often than [coolDown] milliseconds.
         */
        inline fun View.setOnClickListenerCooldown(
            coolDown: Long = 1000L,
            crossinline action: (view: View) -> Unit
        ) {
            setOnClickListener(object : View.OnClickListener {
                var lastTime = 0L
                override fun onClick(v: View) {
                    val now = System.currentTimeMillis()
                    if (now - lastTime > coolDown) {
                        action(v)
                        lastTime = now
                    }
                }
            })
        }

        /**
         * Post functions
         */
        inline fun <T : View> T.postLet(crossinline block: (T) -> Unit) {
            post { block(this) }
        }

        inline fun <T : View> T.postDelayedLet(delay: Long, crossinline block: (T) -> Unit) {
            postDelayed({ block(this) }, delay)
        }

        inline fun <T : View> T.postApply(crossinline block: T.() -> Unit) {
            post { block(this) }
        }

        inline fun <T : View> T.postDelayedApply(delay: Long, crossinline block: T.() -> Unit) {
            postDelayed({ block(this) }, delay)
        }

        fun TabLayout.addTab(
            @StringRes title: Int,
            @DrawableRes icon: Int,
            @LayoutRes customView: Int
        ) {
            val tab = LayoutInflater.from(context)
                .inflate(customView, this as ViewGroup, false) as TextView
            tab.setText(title)
            tab.setCompoundDrawablesWithIntrinsicBounds(icon, 0, 0, 0)
            addTab(newTab().setCustomView(tab))
        }

        fun TabLayout.updateTabAt(
            position: Int,
            @StringRes title: Int,
            @DrawableRes icon: Int,
            @LayoutRes customView: Int
        ) {
            val tab = LayoutInflater.from(context)
                .inflate(customView, this as ViewGroup, false) as TextView
            tab.setText(title)
            tab.setCompoundDrawablesWithIntrinsicBounds(icon, 0, 0, 0)
            getTabAt(position)?.customView = tab
        }

        fun TabLayout.Tabs(): List<TabLayout.Tab> {

            val tabs = mutableListOf<TabLayout.Tab>()

            (0..tabCount).forEach { index: Int ->
                getTabAt(index)?.let { tabs.add(it) }
            }

            return tabs
        }

        fun TextInputLayout.setTextInputLayoutUpperHintColor(@ColorInt color: Int) {
            defaultHintTextColor = ColorStateList(arrayOf(intArrayOf()), intArrayOf(color))
        }

        val View.centerX
            get() = x + width / 2

        val View.centerY
            get() = y + height / 2


        /**
         * Restricts [Int] to be within a [min] and a [max] value
         */
        fun Int.clamp(min: Int, max: Int): Int {
            return max(min, min(max, this))
        }

        /**
         * Adds a leading zero if only one digit
         */
        fun Int.padWithZero(): String {
            return String.format("%02d", this)
        }

        fun TextInputLayout.toggleTextHintColorOnEmpty(activeColor: Int, inactiveColor: Int) =
            setTextInputLayoutUpperHintColor(
                if (editText?.text?.isNotEmpty() == true)
                    activeColor else
                    inactiveColor
            )

        fun View.afterLatestMeasured(callback: () -> Unit) {
            this.post {
                callback()
            }
        }

        fun View.isLaidOutCompat(): Boolean {
            return ViewCompat.isLaidOut(this)
        }

        fun View.setbackgroundColorResource(@ColorRes resId: Int) {
            setBackgroundColor(ContextCompat.getColor(context, resId))
        }

        fun View.toggleVisibility() {
            if (isVisible) gone() else visible()
        }


        infix fun View.and(v: View): List<View> {
            return mutableListOf(this, v)
        }

        infix fun List<View>.and(v: View): List<View> {
            val list = mutableListOf<View>()
            list.addAll(this)
            list.add(v)
            return list
        }


        /**
         * Gives focus to the passed view once the view has been completely inflated
         */
        fun Activity.setFocusToView(view: View) {
            val handler = Handler(this.mainLooper)
            handler.post { view.requestFocus() }
        }

        /**
         * Change Floating action button tint
         */
        fun FloatingActionButton.setTint(color: Int) {
            this.imageTintList = ColorStateList.valueOf(color)
        }


        /**
         * Create a Screnshot of the view and returns it as a Bitmap
         */
        fun View.screenshot(): Bitmap {
            val bmp = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888)
            val canvas = Canvas(bmp)
            draw(canvas)
            canvas.save()
            return bmp
        }


        /**
         * get Activity On Which View is inflated to
         */
        val View.getActivity: Activity?
            get() {
                if (context is Activity)
                    return context as Activity
                return null
            }

        /**
         * Gives focus to the passed view once the view has been completely inflated
         */
        fun Fragment.setFocusToView(view: View) {
            val handler = Handler(this.requireActivity().mainLooper)
            handler.post { view.requestFocus() }
        }

        /**
         * Gives focus to the passed view once the view has been completely
         * inflated using `view.requestFocusFromTouch`
         */
        fun Activity.setTouchFocusToView(view: View) {
            val handler = Handler(this.mainLooper)
            handler.post { view.requestFocusFromTouch() }
        }

        /**
         * Gives focus to the passed view once the view has been completely
         * inflated using `view.requestFocusFromTouch`
         */
        fun Fragment.setTouchFocusToView(view: View) {
            val handler = Handler(this.requireActivity().mainLooper)
            handler.post { view.requestFocusFromTouch() }
        }

        /**
         * Hides all the views passed as argument(s)
         */
        fun Context.hideViews(vararg views: View) = views.forEach { it.visibility = View.GONE }

        /**
         * Shows all the views passed as argument(s)
         */
        fun Context.showViews(vararg views: View) = views.forEach { it.visibility = View.VISIBLE }


        fun View.limitHeight(h: Int, min: Int, max: Int): View {
            val params = layoutParams
            when {
                h < min -> params.height = min
                h > max -> params.height = max
                else -> params.height = h
            }
            layoutParams = params
            return this
        }

        fun View.limitWidth(w: Int, min: Int, max: Int): View {
            val params = layoutParams
            when {
                w < min -> params.width = min
                w > max -> params.width = max
                else -> params.width = w
            }
            layoutParams = params
            return this
        }

        fun View.margins(
            leftMargin: Int = Int.MAX_VALUE,
            topMargin: Int = Int.MAX_VALUE,
            rightMargin: Int = Int.MAX_VALUE,
            bottomMargin: Int = Int.MAX_VALUE
        ): View {
            val params = layoutParams as ViewGroup.MarginLayoutParams
            if (leftMargin != Int.MAX_VALUE)
                params.leftMargin = leftMargin
            if (topMargin != Int.MAX_VALUE)
                params.topMargin = topMargin
            if (rightMargin != Int.MAX_VALUE)
                params.rightMargin = rightMargin
            if (bottomMargin != Int.MAX_VALUE)
                params.bottomMargin = bottomMargin
            layoutParams = params
            return this
        }


        fun View.animateWidth(
            targetValue: Int,
            duration: Long = 400,
            action: ((Float) -> Unit)? = null
        ) {
            ValueAnimator.ofInt(width, targetValue).apply {
                addUpdateListener {
                    setWidth(it.animatedValue as Int)
                    action?.invoke((it.animatedFraction))
                }
                setDuration(duration)
                start()
            }
        }

        fun View.animateHeight(
            targetValue: Int,
            duration: Long = 400,
            action: ((Float) -> Unit)? = null
        ) {
            ValueAnimator.ofInt(height, targetValue).apply {
                addUpdateListener {
                    setHeight(it.animatedValue as Int)
                    action?.invoke((it.animatedFraction))
                }
                setDuration(duration)
                start()
            }
        }


        fun View.animateWidthAndHeight(
            targetWidth: Int,
            targetHeight: Int,
            duration: Long = 400,
            action: ((Float) -> Unit)? = null
        ) {
            val startHeight = height
            val evaluator = IntEvaluator()
            ValueAnimator.ofInt(width, targetWidth).apply {
                addUpdateListener {
                    resize(
                        it.animatedValue as Int,
                        evaluator.evaluate(it.animatedFraction, startHeight, targetHeight)
                    )
                    action?.invoke((it.animatedFraction))
                }
                setDuration(duration)
                start()
            }
        }

        /**
         * Get a screenshot of the View, support a long screenshot of the entire RecyclerView list
         * Note: When calling this method, please make sure the View has been measured. If the width and height are 0, an exception will be thrown.
         */
        fun View.toBitmap(): Bitmap {
            if (measuredWidth == 0 || measuredHeight == 0) {
                throw RuntimeException("When calling this method, please make sure the View has been measured. If the width and height are 0, an exception is thrown as a reminder！")
            }
            return when (this) {
                is RecyclerView -> {
                    this.scrollToPosition(0)
                    this.measure(
                        View.MeasureSpec.makeMeasureSpec(width, View.MeasureSpec.EXACTLY),
                        View.MeasureSpec.makeMeasureSpec(0, View.MeasureSpec.UNSPECIFIED)
                    )

                    val bmp = Bitmap.createBitmap(width, measuredHeight, Bitmap.Config.ARGB_8888)
                    val canvas = Canvas(bmp)

                    //draw default bg, otherwise will be black
                    if (background != null) {
                        background.setBounds(0, 0, width, measuredHeight)
                        background.draw(canvas)
                    } else {
                        canvas.drawColor(Color.WHITE)
                    }
                    this.draw(canvas)
                    // reset height
                    this.measure(
                        View.MeasureSpec.makeMeasureSpec(width, View.MeasureSpec.EXACTLY),
                        View.MeasureSpec.makeMeasureSpec(height, View.MeasureSpec.AT_MOST)
                    )
                    bmp //return
                }
                else -> {
                    val screenshot =
                        Bitmap.createBitmap(measuredWidth, measuredHeight, Bitmap.Config.ARGB_4444)
                    val canvas = Canvas(screenshot)
                    if (background != null) {
                        background.setBounds(0, 0, width, measuredHeight)
                        background.draw(canvas)
                    } else {
                        canvas.drawColor(Color.WHITE)
                    }
                    draw(canvas)// Draw the view onto the canvas
                    screenshot //return
                }
            }
        }


        /**
         * Attaches a listener to the recyclerview to hide the fab when it is scrolling downwards
         * The fab will reappear when scrolling has stopped or if the user scrolls up
         */
        fun FloatingActionButton.hideOnDownwardsScroll(recycler: RecyclerView) {
            recycler.addOnScrollListener(object : RecyclerView.OnScrollListener() {

                override fun onScrollStateChanged(recyclerView: RecyclerView, newState: Int) {
                    if (newState == RecyclerView.SCROLL_STATE_IDLE && !isShown) show()
                }

                override fun onScrolled(recyclerView: RecyclerView, dx: Int, dy: Int) {
                    if (dy > 0 && isShown) hide()
                    else if (dy < 0 && isOrWillBeHidden) show()
                }
            })
        }

        inline var View.scaleXY
            get() = Math.max(scaleX, scaleY)
            set(value) {
                scaleX = value
                scaleY = value
            }


        fun View.elevate(elevation: Float) = setElevation(elevation)

        val View.isAttachedToAWindow: Boolean
            get() {
                return isAttachedToWindow
            }

        fun View.isInBounds(container: View): Boolean {
            val containerBounds = Rect()
            container.getHitRect(containerBounds)
            return getLocalVisibleRect(containerBounds)
        }

        /**
         * Creates an on touch listener that only emits on a short single tap
         */
        @SuppressLint("ClickableViewAccessibility")
        inline fun View.setOnSingleTapListener(crossinline onSingleTap: (v: View, event: MotionEvent) -> Unit) {
            setOnTouchListener { v, event ->
                when (event.actionMasked) {
                    MotionEvent.ACTION_DOWN -> true
                    MotionEvent.ACTION_UP -> {
                        if (event.eventTime - event.downTime < 100)
                            onSingleTap(v, event)
                        true
                    }
                    else -> false
                }
            }
        }

        fun BottomSheetBehavior<*>.onSlide(onSlide: (bottomSheet: View, slideOffset: Float) -> Unit = { _, _ -> }): BottomSheetBehavior.BottomSheetCallback {
            val listener = object : BottomSheetBehavior.BottomSheetCallback() {
                override fun onSlide(bottomSheet: View, slideOffset: Float) {
                    onSlide(bottomSheet, slideOffset)
                }

                override fun onStateChanged(bottomSheet: View, newState: Int) {
                }

            }
            addBottomSheetCallback(listener)
            return listener
        }

        fun BottomSheetBehavior<*>.onStateChanged(onStateChanged: (bottomSheet: View, newState: Int) -> Unit = { _, _ -> }): BottomSheetBehavior.BottomSheetCallback {
            val listener = object : BottomSheetBehavior.BottomSheetCallback() {
                override fun onSlide(bottomSheet: View, slideOffset: Float) {
                }

                override fun onStateChanged(bottomSheet: View, newState: Int) {
                    onStateChanged(bottomSheet, newState)
                }

            }
            addBottomSheetCallback(listener)
            return listener
        }

        fun View.getLocationOnScreen() = IntArray(2).apply { getLocationOnScreen(this) }

        fun View.getLocationInWindow() = IntArray(2).apply { getLocationInWindow(this) }

        operator fun TabLayout.get(position: Int): TabLayout.Tab = getTabAt(position)!!

        inline fun TabLayout.forEach(func: (TabLayout.Tab) -> Unit) {
            for (i in 0 until tabCount) func(get(i))
        }

        fun TabLayout.tint(
            selectedPosition: Int = 0,
            selectedColor: Int = ContextCompat.getColor(context, android.R.color.white),
            defaultColor: Int = Color.parseColor("#80FFFFFF")
        ) {
            forEach { it.icon?.setTint(defaultColor) }
            get(selectedPosition).icon?.setTint(selectedColor)
        }

        fun TabLayout.hideTitles() = forEach {
            it.contentDescription = it.text
            it.text = ""
        }

        fun TabLayout.setIcons(icons: List<Drawable>) {
            for (i in 0 until tabCount) get(i).icon = icons[i]
            tint()
        }

        fun TabLayout.setIcons(@DrawableRes icons: Array<Int>) {
            for (i in 0 until tabCount) get(i).icon = ContextCompat.getDrawable(context, icons[i])
            tint()
        }

        fun TabLayout.setIcons(icons: TypedArray) {
            for (i in 0 until tabCount) get(i).icon = icons.getDrawable(i)
            tint()
        }

        fun TabLayout.getTabViewAt(position: Int) =
            (getChildAt(0) as ViewGroup).getChildAt(position)

        fun Array<View>.gone() {
            forEach {
                it.gone()
            }
        }

        fun ProgressBar.indeterminateDrawableColor(@ColorRes color: Int) {
            indeterminateDrawable.setColorFilter(
                ContextCompat.getColor(context, color), PorterDuff.Mode.SRC_IN
            )
        }

        fun View.aspect(ratio: Float = 3 / 4f) =
            post {
                val params = layoutParams
                params.height = (width / ratio).toInt()
                layoutParams = params
            }


        fun View.waitForLayout(onGlobalLayoutListener: ViewTreeObserver.OnGlobalLayoutListener) {
            viewTreeObserver.addOnGlobalLayoutListener(object :
                ViewTreeObserver.OnGlobalLayoutListener {
                override fun onGlobalLayout() {
                    viewTreeObserver.removeOnGlobalLayoutListener(this)
                    onGlobalLayoutListener.onGlobalLayout()
                }
            })
        }


        inline fun <T : View> T.style(block: T.() -> Unit): T {
            return this.apply(block)
        }

        enum class Anchor {
            LEFT,
            RIGHT,
            TOP,
            BOTTOM,
            CENTERX,
            CENTERY
//    BASELINE(ConstraintLayout.LayoutParams.BASELINE),
//    START(ConstraintLayout.LayoutParams.START),
//    END(ConstraintLayout.LayoutParams.END)
        }

        fun alignLefts(vararg views: View) = align(Anchor.LEFT, views)
        fun alignRights(vararg views: View) = align(Anchor.RIGHT, views)
        fun alignTops(vararg views: View) = align(Anchor.TOP, views)
        fun alignBottoms(vararg views: View) = align(Anchor.BOTTOM, views)
        fun alignHorizontally(vararg views: View) = align(Anchor.CENTERY, views)
        fun alignVertically(vararg views: View) = align(Anchor.CENTERX, views)

        private fun align(edge: Anchor, views: Array<out View>) {
            var firstView: View? = null
            views.forEachIndexed { index, view ->
                if (index == 0) {
                    firstView = view
                } else {
                    when (edge) {
                        Anchor.LEFT -> view.constrainLeftToLeftOf(firstView!!)
                        Anchor.RIGHT -> view.constrainRightToRightOf(firstView!!)
                        Anchor.TOP -> view.constrainTopToTopOf(firstView!!)
                        Anchor.BOTTOM -> view.constrainBottomToBottomOf(firstView!!)
                        Anchor.CENTERX -> view.constrainCenterXToCenterXOf(firstView!!)
                        Anchor.CENTERY -> view.constrainCenterYToCenterYOf(firstView!!)
                    }
                }
            }
        }

        // Constants
        const val matchConstraint = ConstraintSet.MATCH_CONSTRAINT
        const val matchParent: Int = ViewGroup.LayoutParams.MATCH_PARENT
        const val wrapContent: Int = ViewGroup.LayoutParams.WRAP_CONTENT

// Style - Colors

        fun View.color(resourceId: Int): Int {
            return ContextCompat.getColor(context, resourceId)
        }

        var TextView.textColor: Int
            get() = 0
            set(v) = setTextColor(v)

        var Button.textColor: Int
            get() = 0
            set(v) = setTextColor(v)

        var View.padding: Int
            get() = 0
            inline set(value) = setPadding(value, value, value, value)

        var View.backgroundColor: Int
            get() = 0
            set(v) = setBackgroundColor(v)

// Style - Pixel densities

        var Int.dp: Int
            get() {
                val metrics = Resources.getSystem().displayMetrics
                return TypedValue.applyDimension(
                    TypedValue.COMPLEX_UNIT_DIP,
                    this.toFloat(),
                    metrics
                ).toInt()
            }
            set(_) {}


        var Float.dp: Float
            get() {
                val metrics = Resources.getSystem().displayMetrics
                return TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_DIP, this, metrics)
            }
            set(_) {}


        fun Number.dpToPx(context: Context? = null): Float {
            val res = context?.resources ?: Resources.getSystem()
            return this.toFloat() * res.displayMetrics.density
        }

        fun Number.pxToDp(context: Context? = null): Float {
            val res = context?.resources ?: Resources.getSystem()
            return this.toFloat() / res.displayMetrics.density
        }

        fun Number.spToPx(context: Context? = null): Float {
            val res = context?.resources ?: Resources.getSystem()
            return this.toFloat() * res.displayMetrics.scaledDensity
        }

        fun Number.pxToSp(context: Context? = null): Float {
            val res = context?.resources ?: Resources.getSystem()
            return this.toFloat() / res.displayMetrics.scaledDensity
        }

// Layout - Helpers

        fun ConstraintLayout.addConstraints(block: ConstraintSet.() -> Unit) {
            val cs = ConstraintSet()
            cs.clone(this)
            block(cs)
            cs.applyTo(this)
        }


        /// Represents a side of the parent view.
        object I

        class SinglePartialConstraint(val view: View, val margin: Int)

        class MultiplePartialConstraint(val views: Array<View>, val margin: Int)

        class SideConstraint(val constant: Int)


        // I-view
        operator fun I.minus(view: View): View {
            view.left(0)
            return view
        }

        // I-42
        operator fun I.minus(margin: Int): SideConstraint {
            return SideConstraint(margin)
        }

        // (I-42)-view
        operator fun SideConstraint.minus(view: View): View {
            view.left(constant)
            return view
        }

        // view-I
        operator fun View.minus(side: I): View {
            this.right(0)
            return this
        }

        // (view-42)-I
        operator fun SinglePartialConstraint.minus(side: I): View {
            view.right(margin)
            return view
        }

        // viewA-viewB
        operator fun View.minus(view: View): Array<View> {
            // Somehow these don't have the same effect.
            // (not reflexive)
//    view.constrainLeftToRightOf(this)
            this.constrainRightToLeftOf(view)
            return arrayOf(this, view)
        }

        // view-42
        operator fun View.minus(margin: Int): SinglePartialConstraint {
            return SinglePartialConstraint(this, margin)
        }

        // (previousView-42)-view
        operator fun SinglePartialConstraint.minus(right: View): Array<View> {
            right.constrainLeftToRightOf(view, margin)
            return arrayOf(view, right)
        }

        // (viewA-viewB)-I
        operator fun Array<View>.minus(side: I): Array<View> {
            lastOrNull()?.right(0)
            return this
        }

        // (viewA-viewB)-42
        operator fun Array<View>.minus(margin: Int): MultiplePartialConstraint {
            return MultiplePartialConstraint(this, margin)
        }

        // (viewA-viewB)-(42-I)
        operator fun MultiplePartialConstraint.minus(side: I): Array<View> {
            views.last().right(margin)
            return views
        }

        // (viewA-viewB-42)-view
        operator fun MultiplePartialConstraint.minus(view: View): Array<View> {
            view.constrainLeftToRightOf(views.last(), margin)
            return views + view
        }

        fun horizontalLayout(vararg items: Any): Array<out Any> {
            var previousMargin: Int? = null
            var previousView: View? = null
            for ((viewCount, item) in items.withIndex()) {

                when (item) {
                    is Int -> {
                        previousMargin = item
                        if (viewCount == items.count() - 1) { // Last Margin == Bottom
                            previousView?.let { previousView ->
                                previousView.right(item)
                            }
                        }
                    }
                    is View -> {
                        previousMargin?.let { previousMargin ->
                            if (viewCount == 1) {
                                item.left(previousMargin)
                            } else {
                                previousView?.let { previousView ->

                                    item.constrainLeftToRightOf(previousView, previousMargin)
//                            item.constrainRightToLeftOf(previousView, previousMargin)
                                }
                            }
                        }
                        previousView = item
                    }
                    is String -> {
                        previousMargin = null
                        previousView = null
                    }
                }
            }
            return items
        }


        fun <T : View> T.centerInParent(): T {
            return centerHorizontally().centerVertically()
        }

        fun <T : View> T.centerHorizontally(): T {
            (parent as? ConstraintLayout)?.let { constraintLayout ->
                constraintLayout.addConstraints {
                    centerHorizontally(id, constraintLayout.id)
                }
            }
            return this
        }

        fun <T : View> T.centerVertically(): T {
            (parent as? ConstraintLayout)?.let { constraintLayout ->
                constraintLayout.addConstraints {
                    centerVertically(id, constraintLayout.id)
                }
            }
            return this
        }


        fun <T : View> T.fillParent(padding: Int = 0): T {
            return fillVertically(padding).fillHorizontally(padding)
        }

        fun <T : View> T.fillVertically(padding: Int = 0): T {
            layoutParams.height = ConstraintSet.MATCH_CONSTRAINT // Needed to "match constraints"
            return top(padding).bottom(padding)
        }

        fun <T : View> T.fillHorizontally(padding: Int = 0): T {
            layoutParams.width = ConstraintSet.MATCH_CONSTRAINT // Needed to "match constraints"
            return left(padding).right(padding)
        }


        fun <T : View> T.top(margin: Int): T {
            return position(ConstraintLayout.LayoutParams.TOP, margin)
        }

        fun <T : View> T.left(margin: Int): T {
            return position(ConstraintLayout.LayoutParams.LEFT, margin)
        }

        fun <T : View> T.right(margin: Int): T {
            return position(ConstraintLayout.LayoutParams.RIGHT, margin)
        }

        fun <T : View> T.bottom(margin: Int): T {
            return position(ConstraintLayout.LayoutParams.BOTTOM, margin)
        }

        fun <T : View> T.position(position: Int, margin: Int): T {
            (parent as? ConstraintLayout)?.let { constraintLayout ->
                constraintLayout.addConstraints {
                    connect(
                        id,
                        position,
                        ConstraintLayout.LayoutParams.PARENT_ID,
                        position,
                        margin.dp
                    )
                }
            }
            return this
        }


// Top

        fun <T : View> T.constrainTopToBottomOf(view: View, margin: Int = 0): T {
            return constrainTopToBottomOf(view.id, margin)
        }

        fun <T : View> T.constrainTopToBottomOf(viewId: Int, margin: Int = 0): T {
            (parent as? ConstraintLayout)?.addConstraints {
                connect(
                    id,
                    ConstraintLayout.LayoutParams.TOP,
                    viewId,
                    ConstraintLayout.LayoutParams.BOTTOM,
                    margin.dp
                )
            }
            return this
        }

        fun <T : View> T.constrainTopToTopOf(view: View, margin: Int = 0): T {
            return constrainTopToTopOf(view.id, margin)
        }

        fun <T : View> T.constrainTopToTopOf(viewId: Int, margin: Int = 0): T {
            (parent as? ConstraintLayout)?.addConstraints {
                connect(
                    id,
                    ConstraintLayout.LayoutParams.TOP,
                    viewId,
                    ConstraintLayout.LayoutParams.TOP,
                    margin.dp
                )
            }
            return this
        }


// Left

        fun <T : View> T.constrainLeftToRightOf(view: View, margin: Int = 0): T {
            return constrainLeftToRightOf(view.id, margin)
        }

        fun <T : View> T.constrainLeftToRightOf(viewId: Int, margin: Int = 0): T {
            (parent as? ConstraintLayout)?.addConstraints {
                connect(
                    id,
                    ConstraintLayout.LayoutParams.LEFT,
                    viewId,
                    ConstraintLayout.LayoutParams.RIGHT,
                    margin.dp
                )
            }

            return this
        }

        fun <T : View> T.constrainLeftToLeftOf(view: View, margin: Int = 0): T {
            return constrainLeftToLeftOf(view.id, margin)
        }

        fun <T : View> T.constrainLeftToLeftOf(viewId: Int, margin: Int = 0): T {
            (parent as? ConstraintLayout)?.addConstraints {
                connect(
                    id,
                    ConstraintLayout.LayoutParams.LEFT,
                    viewId,
                    ConstraintLayout.LayoutParams.LEFT,
                    margin.dp
                )
            }

            return this
        }

// Right

        fun <T : View> T.constrainRightToLeftOf(view: View, margin: Int = 0): T {
            return constrainRightToLeftOf(view.id, margin)
        }

        fun <T : View> T.constrainRightToLeftOf(viewId: Int, margin: Int = 0): T {
            (parent as? ConstraintLayout)?.addConstraints {
                connect(
                    id,
                    ConstraintLayout.LayoutParams.RIGHT,
                    viewId,
                    ConstraintLayout.LayoutParams.LEFT,
                    margin.dp
                )
            }

            return this
        }

        fun <T : View> T.constrainRightToRightOf(view: View, margin: Int = 0): T {
            return constrainRightToRightOf(view.id, margin)
        }

        fun <T : View> T.constrainRightToRightOf(viewId: Int, margin: Int = 0): T {
            (parent as? ConstraintLayout)?.addConstraints {
                connect(
                    id,
                    ConstraintLayout.LayoutParams.RIGHT,
                    viewId,
                    ConstraintLayout.LayoutParams.RIGHT,
                    margin.dp
                )
            }

            return this
        }

// Bottom

        fun <T : View> T.constrainBottomToTopOf(view: View, margin: Int = 0): T {
            return constrainBottomToTopOf(view.id, margin)
        }

        fun <T : View> T.constrainBottomToTopOf(viewId: Int, margin: Int = 0): T {
            (parent as? ConstraintLayout)?.addConstraints {
                connect(
                    id,
                    ConstraintLayout.LayoutParams.BOTTOM,
                    viewId,
                    ConstraintLayout.LayoutParams.TOP,
                    margin.dp
                )
            }
            return this
        }

        fun <T : View> T.constrainBottomToBottomOf(view: View, margin: Int = 0): T {
            return constrainBottomToBottomOf(view.id, margin)
        }

        fun <T : View> T.constrainBottomToBottomOf(viewId: Int, margin: Int = 0): T {
            (parent as? ConstraintLayout)?.addConstraints {
                connect(
                    id,
                    ConstraintLayout.LayoutParams.BOTTOM,
                    viewId,
                    ConstraintLayout.LayoutParams.BOTTOM,
                    margin.dp
                )
            }
            return this
        }


// Center Y

        // This is made possible by creating a "GONE" guideline and center on the guideline instead :)
        fun <T : View> T.constrainCenterYToBottomOf(view: View): T {
            (parent as? ConstraintLayout)?.let { constraintLayout ->
                constraintLayout.addConstraints {
                    val guideline = View(context)
                    guideline.id = View.generateViewId()
                    constraintLayout.addView(guideline)
                    guideline.visibility = View.GONE
                    guideline.constrainBottomToBottomOf(view)
                    centerVertically(id, guideline.id)
                }
            }
            return this
        }

        fun <T : View> T.constrainCenterYToTopOf(view: View): T {
            (parent as? ConstraintLayout)?.let { constraintLayout ->
                constraintLayout.addConstraints {
                    val guideline = View(context)
                    guideline.id = View.generateViewId()
                    constraintLayout.addView(guideline)
                    guideline.visibility = View.GONE
                    guideline.constrainTopToTopOf(view)
                    centerVertically(id, guideline.id)
                }
            }
            return this
        }

        fun <T : View> T.constrainCenterYToCenterYOf(view: View): T {
            (parent as? ConstraintLayout)?.addConstraints {
                centerVertically(id, view.id)
            }
            return this
        }


// Center X

        fun <T : View> T.constrainCenterXToLeftOf(view: View): T {
            (parent as? ConstraintLayout)?.let { constraintLayout ->
                constraintLayout.addConstraints {
                    val guideline = View(context)
                    guideline.id = View.generateViewId()
                    constraintLayout.addView(guideline)
                    guideline.visibility = View.GONE
                    guideline.constrainLeftToLeftOf(view)
                    centerHorizontally(id, guideline.id)
                }
            }
            return this
        }

        fun <T : View> T.constrainCenterXToRightOf(view: View): T {
            (parent as? ConstraintLayout)?.let { constraintLayout ->
                constraintLayout.addConstraints {
                    val guideline = View(context)
                    guideline.id = View.generateViewId()
                    constraintLayout.addView(guideline)
                    guideline.visibility = View.GONE
                    guideline.constrainRightToRightOf(view)
                    centerHorizontally(id, guideline.id)
                }
            }
            return this
        }


        fun <T : View> T.constrainCenterXToCenterXOf(view: View): T {
            (parent as? ConstraintLayout)?.addConstraints {
                centerHorizontally(id, view.id)
            }
            return this
        }


// Follow Edges

        fun <T : View> T.followEdgesOf(view: View, margin: Int = 0): T {
            constrainTopToTopOf(view)
            constrainBottomToBottomOf(view)
            constrainLeftToLeftOf(view)
            constrainRightToRightOf(view)
            return this
        }


// Layout - Size

        fun <T : View> T.size(value: Int): T {
            return width(value).height(value)
        }

        fun <T : View> T.width(value: Int): T {
            return width(value.toFloat())
        }

        fun <T : View> T.height(value: Int): T {
            return height(value.toFloat())
        }

        fun <T : View> T.width(value: Float): T {

            if (value.toInt() == ConstraintSet.MATCH_CONSTRAINT) {
                layoutParams.width = value.toInt()
                return this
            }

            if (parent is ConstraintLayout) {
                (parent as? ConstraintLayout)?.let { constraintLayout ->
                    constraintLayout.addConstraints {
                        constrainWidth(id, value.dp.toInt())
                    }
                }
            } else {
                if (layoutParams == null) {
                    layoutParams = ViewGroup.LayoutParams(
                        ConstraintSet.WRAP_CONTENT,
                        ConstraintSet.WRAP_CONTENT
                    )
                }

                if (layoutParams != null) {
                    layoutParams.width = if (value > 0) value.dp.toInt() else value.toInt()
                } else {

                    print("NULL")
                }
            }
            return this
        }

        fun <T : View> T.height(value: Float): T {

            if (value.toInt() == ConstraintSet.MATCH_CONSTRAINT) {
                layoutParams.height = value.toInt()
                return this
            }

            if (parent is ConstraintLayout) {
                (parent as? ConstraintLayout)?.let { constraintLayout ->
                    constraintLayout.addConstraints {
                        constrainHeight(id, value.dp.toInt())
                    }
                }
            } else {

                if (layoutParams == null) {
                    layoutParams = ViewGroup.LayoutParams(
                        ConstraintSet.WRAP_CONTENT,
                        ConstraintSet.WRAP_CONTENT
                    )
                }

                if (layoutParams != null) {
                    layoutParams.height = if (value > 0) value.dp.toInt() else value.toInt()
                }
            }
            return this
        }


// Percent Size

        fun <T : View> T.percentWidth(value: Float): T {
            layoutParams.width = ConstraintSet.MATCH_CONSTRAINT
            (parent as? ConstraintLayout)?.let { constraintLayout ->
                constraintLayout.addConstraints {
                    constrainPercentWidth(id, value)
                }
            }
            return this
        }

        fun <T : View> T.percentHeight(value: Float): T {
            layoutParams.height = ConstraintSet.MATCH_CONSTRAINT
            (parent as? ConstraintLayout)?.let { constraintLayout ->
                constraintLayout.addConstraints {
                    constrainPercentHeight(id, value)
                }
            }
            return this
        }


    }
}