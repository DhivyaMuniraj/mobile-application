package com.ces.androidframework.stringhelper

import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.Color
import android.graphics.Typeface
import android.net.Uri
import android.os.Build
import android.text.*
import android.text.style.*
import android.util.Base64
import android.util.Patterns
import android.view.View
import android.widget.TextView
import androidx.annotation.PluralsRes
import androidx.annotation.StringRes
import androidx.annotation.StyleRes
import com.ces.androidframework.bytearray.base64Encode
import com.ces.androidframework.bytearray.base64EncodeToString
import com.ces.androidframework.miscellaneous.tryOrElse
import org.intellij.lang.annotations.RegExp
import java.io.File
import java.io.FileOutputStream
import java.io.UnsupportedEncodingException
import java.net.URLDecoder
import java.net.URLEncoder
import java.security.MessageDigest
import java.security.NoSuchAlgorithmException
import java.security.SignatureException
import java.text.DateFormat
import java.text.Normalizer
import java.text.ParseException
import java.util.*
import java.util.regex.Pattern
import javax.crypto.Cipher
import javax.crypto.Mac
import javax.crypto.spec.SecretKeySpec
import kotlin.collections.HashMap

class StringUtils {


    companion object {
        const val NEW_LINE = "\n"

        fun removeLastChar(stringText: String?, endingChar: String?): String? {
            var stringText = stringText
            if (stringText != "" && stringText != null) {
                if (stringText.endsWith(endingChar!!)) {
                    stringText = stringText.substring(0, stringText.length - 1)
                }
            }
            return stringText
        }


        val String.decodeBase64: String
            get() = Base64.decode(this, Base64.DEFAULT).toString(Charsets.UTF_8)
        val String.encodeBase64: String
            get() = Base64.encodeToString(
                this.toByteArray(Charsets.UTF_8),
                Base64.DEFAULT
            )

        fun String?.isNotNullOrEmpty(): Boolean {
            return !this.isNullOrEmpty()
        }

        val String.isAlphanumeric get() = matches("^[a-zA-Z0-9]*$".toRegex())

        val String.isAlphabetic get() = matches("^[a-zA-Z]*$".toRegex())

        val String.mostCommonCharacter: Char?
            get() {
                if (length == 0) return null
                val map = HashMap<Char, Int>()
                for (char in toCharArray()) map[char] = (map[char] ?: 0) + 1
                var maxEntry = map.entries.elementAt(0)
                for (entry in map) maxEntry = if (entry.value > maxEntry.value) entry else maxEntry
                return maxEntry.key
            }


        fun <T> T.concatAsString(b: T): String {
            return this.toString() + b.toString()
        }


        /**
         * Get md5 string.
         */
        val String.md5 get() = hashAString(this, "MD5", toByteArray())

        /**
         * Get sha1 string.
         */
        val String.sha1 get() = hashAString(this, "SHA-1", toByteArray())


        /**
         * Returns a new File Object with the Current String as Its path
         */
        val String.asFile get() = File(this)


        /**
         * Returns a new File Object with the Current String as Its path
         */
        fun String.asFile() = File(this)


        /**
         * Encode String to URL
         */
        val String.encodeToUrlUTF8: String
            get() {
                return URLEncoder.encode(this, "UTF-8")
            }

        /**
         * Decode String to URL
         */
        val String.decodeToUrlUTF8: String
            get() {
                return URLDecoder.decode(this, "UTF-8")
            }

        /**
         * Encode String to URL
         */
        fun String.encodeToUrl(charSet: String = "UTF-8"): String = URLEncoder.encode(this, charSet)

        /**
         * Decode String to URL
         */
        fun String.decodeToUrl(charSet: String = "UTF-8"): String = URLDecoder.decode(this, charSet)

        /**
         **
         * Encrypt String to AES with the specific Key
         */
        fun String.encryptAES(key: String): String {
            var crypted: ByteArray? = null
            try {
                val skey = SecretKeySpec(key.toByteArray(), "AES")
                val cipher = Cipher.getInstance("AES/PKCS5Padding")
                cipher.init(Cipher.ENCRYPT_MODE, skey)
                crypted = cipher.doFinal(toByteArray())
            } catch (e: Exception) {
                println(e.toString())
            }
            return String(Base64.encode(crypted, Base64.DEFAULT))
        }

        /**
         * Decrypt String to AES with the specific Key
         */
        fun String.decryptAES(key: String): String? {
            var output: ByteArray? = null
            try {
                val skey = SecretKeySpec(key.toByteArray(), "AES")
                val cipher = Cipher.getInstance("AES/PKCS5Padding")
                cipher.init(Cipher.DECRYPT_MODE, skey)
                output = cipher.doFinal(Base64.decode(this, Base64.DEFAULT))
            } catch (e: Exception) {
                println(e.toString())
            }
            return output?.let { String(it) }
        }

        /**
         * encode The String to Binary
         */
        fun String.encodeToBinary(): String {
            val stringBuilder = StringBuilder()
            toCharArray().forEach {
                stringBuilder.append(Integer.toBinaryString(it.toInt()))
                stringBuilder.append(" ")
            }
            return stringBuilder.toString()
        }

        /**
         * Decode the String from binary
         */
        val String.deCodeToBinary: String
            get() {
                val stringBuilder = StringBuilder()
                split(" ").forEach {
                    stringBuilder.append(Integer.parseInt(it.replace(" ", ""), 2))
                }
                return stringBuilder.toString()
            }

        /**
         * Save String to a Given File
         */
        fun String.saveToFile(file: File) = FileOutputStream(file).bufferedWriter().use {
            it.write(this)
            it.flush()
            it.close()
        }

        /**
         * Method to convert byteArray to String.
         */
        private fun bytes2Hex(bts: ByteArray): String {
            var des = ""
            var tmp: String
            for (i in bts.indices) {
                tmp = Integer.toHexString(bts[i].toInt() and 0xFF)
                if (tmp.length == 1) {
                    des += "0"
                }
                des += tmp
            }
            return des
        }

        /**
         * Method to get encrypted string.
         */
        private fun hashAString(string: String?, type: String, salt: ByteArray): String? {
            if (string.isNullOrEmpty()) {
                return null
            }
            val messageDigest: MessageDigest
            return try {
                messageDigest = MessageDigest.getInstance(type)
                val bytes = messageDigest.digest(salt)
                bytes2Hex(bytes)
            } catch (e: NoSuchAlgorithmException) {
                null
            }
        }

        /**
         * Clear all HTML tags from a string.
         */
        fun String.clearHtmlTags(): String {
            return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                Html.fromHtml(this, Html.FROM_HTML_MODE_LEGACY).toString()
            } else {
                @Suppress("DEPRECATION")
                Html.fromHtml(this).toString()
            }
        }

        /**
         * Returns true if this string contains exactly the provided string.
         * This method uses RegEx to evaluate and its case-sensitive. What makes it different from the classic
         * [contains] is that it doesn't uses [indexOf], hence it's more performant when used on long char sequences
         * and has much higher probabilities of not returning false positives per approximation.
         */
        fun String.containsExact(string: String): Boolean =
            Pattern.compile("(?<=^|[^a-zA-Z0-9])\\Q$string\\E(?=\$|[^a-zA-Z0-9])")
                .matcher(this)
                .find()


        /**
         * Converts a string to boolean such as 'Y', 'yes', 'TRUE'
         */

        fun String.toBoolean(): Boolean {
            return this != "" &&
                    (this.equals("TRUE", ignoreCase = true)
                            || this.equals("Y", ignoreCase = true)
                            || this.equals("YES", ignoreCase = true))
        }

        /**
         * Converts string to camel case. Handles multiple strings and empty strings
         */
        fun String.convertToCamelCase(): String {
            var titleText = ""
            if (this.isNotEmpty()) {
                val words = this.split(" ".toRegex()).dropLastWhile { it.isEmpty() }.toTypedArray()
                words.filterNot { it.isEmpty() }
                    .map { it.substring(0, 1).uppercase() + it.substring(1).lowercase() }
                    .forEach { titleText += "$it " }
            }
            return titleText.trim { it <= ' ' }
        }

        fun String.ellipsize(at: Int): String {
            if (this.length > at) {
                return this.substring(0, at) + "..."
            }
            return this
        }

        @Suppress("DEPRECATION")
        fun String.htmlToSpanned(): Spanned {
            return if (Build.VERSION.SDK_INT >= 24) {
                Html.fromHtml(this, Html.FROM_HTML_MODE_LEGACY)
            } else {
                Html.fromHtml(this)
            }
        }

        /**
         * Normalize string - convert to lowercase, replace diacritics
         */
        fun String.normalize(): String {
            return Normalizer.normalize(lowercase(), Normalizer.Form.NFD)
                .replace("[\\p{InCombiningDiacriticalMarks}]".toRegex(), "")
        }

        /**
         * Highlight substring [query] in this spannable with custom [style]. All occurrences of this substring
         * are stylized
         */
        fun Spannable.highlightSubstring(query: String, @StyleRes style: Int): Spannable {
            val spannable = Spannable.Factory.getInstance().newSpannable(this)
            val substrings =
                query.lowercase().split("\\s+".toRegex()).dropLastWhile(String::isEmpty)
                    .toTypedArray()
            var lastIndex = 0
            for (i in substrings.indices) {
                do {
                    lastIndex = this.toString().lowercase().indexOf(substrings[i], lastIndex)
                    if (lastIndex != -1) {
                        spannable.setSpan(
                            StyleSpan(style),
                            lastIndex,
                            lastIndex + substrings[i].length,
                            Spannable.SPAN_EXCLUSIVE_INCLUSIVE
                        )
                        lastIndex++
                    }
                } while (lastIndex != -1)
            }
            return spannable
        }

        // Part two

        inline fun String.ifIsNullOrEmpty(action: () -> Unit) {
            if (isNullOrEmpty()) action()
        }

        inline fun String.ifIsNotNullOrEmpty(action: () -> Unit) {
            if (!isNullOrEmpty()) action()
        }

        fun String.urlEncoded(): String? = URLEncoder.encode(this, "utf-8")


        inline val String?.doubleValue: Double
            get() = if (TextUtils.isEmpty(this)) 0.0 else try {
                this!!.toDouble()
            } catch (e: Exception) {
                0.0
            }

        inline val String?.intValue: Int
            get() = if (TextUtils.isEmpty(this)) 0 else try {
                this!!.toInt()
            } catch (e: Exception) {
                0
            }

        inline val String?.floatValue: Float
            get() = if (TextUtils.isEmpty(this)) 0f else try {
                this!!.toFloat()
            } catch (e: Exception) {
                0f
            }

        inline val CharSequence?.intValue: Int
            get() = toString().intValue

        inline val CharSequence?.floatValue: Float
            get() = toString().floatValue


        inline val String.isIp: Boolean
            get() {
                val p = Pattern.compile(
                    "([1-9]|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])(\\.(\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])){3}"
                )
                val m = p.matcher(this)
                return m.find()
            }

        fun stringPairOf(vararg pair: Pair<String, Any?>): String {
            val strList = ArrayList<String>(pair.size)
            for ((key, value) in pair) {
                strList.add("$key: $value")
            }
            return strList.joinToString()
        }


        fun String.wrapInQuotes(): String {
            var formattedConfigString: String = this
            if (!startsWith("\"")) {
                formattedConfigString = "\"$formattedConfigString"
            }
            if (!endsWith("\"")) {
                formattedConfigString = "$formattedConfigString\""
            }
            return formattedConfigString
        }

        fun String.unwrapQuotes(): String {
            var formattedConfigString: String = this
            if (formattedConfigString.startsWith("\"")) {
                if (formattedConfigString.length > 1) {
                    formattedConfigString = formattedConfigString.substring(1)
                } else {
                    formattedConfigString = ""
                }
            }
            if (formattedConfigString.endsWith("\"")) {
                if (formattedConfigString.length > 1) {
                    formattedConfigString =
                        formattedConfigString.substring(0, formattedConfigString.length - 1)
                } else {
                    formattedConfigString = ""
                }
            }
            return formattedConfigString
        }


        fun CharSequence.isEmail() = isNotBlank() && Patterns.EMAIL_ADDRESS.matcher(this).matches()

        fun CharSequence?.orDefault(defaultValue: CharSequence): CharSequence =
            if (isNullOrBlank()) defaultValue else this!!


        fun String?.urlEncode(charsetName: String = "UTF-8"): String {
            if (this.isNullOrEmpty()) return ""
            try {
                return URLEncoder.encode(this, charsetName)
            } catch (e: UnsupportedEncodingException) {
                throw AssertionError(e)
            }
        }

        fun String?.urlDecode(charsetName: String = "UTF-8"): String {
            if (this.isNullOrEmpty()) return ""
            try {
                return URLDecoder.decode(this, charsetName)
            } catch (e: UnsupportedEncodingException) {
                throw AssertionError(e)
            }
        }


        fun charToByte(c: Char): Byte {
            return "0123456789ABCDEF".indexOf(c).toByte()
        }

        fun String.convertToBytes(): ByteArray {
            if (this == "") {
                return ByteArray(0)
            }
            val newHexString = this.trim().uppercase()
            val length = newHexString.length / 2
            val hexChars = newHexString.toCharArray()
            val d = ByteArray(length)
            for (i in 0 until length) {
                val pos = i * 2
                d[i] =
                    (charToByte(hexChars[pos]).toInt() shl 4 or charToByte(hexChars[pos + 1]).toInt()).toByte()
            }
            return d
        }


        fun String.base64Encode(): ByteArray {
            return this.toByteArray().base64Encode()
        }

        fun String.base64EncodeToString(): String {
            return this.toByteArray().base64EncodeToString()
        }

        fun String.base64Decode(): ByteArray {
            if (this.isEmpty()) return ByteArray(0)
            return Base64.decode(this, Base64.NO_WRAP)
        }

        fun CharSequence?.isMatch(regex: String): Boolean {
            return !this.isNullOrEmpty() && Regex(regex).matches(this)
        }

        fun CharSequence.setBackgroundColor(color: Int): CharSequence {
            val s = SpannableString(this)
            s.setSpan(BackgroundColorSpan(color), 0, s.length, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE)
            return s
        }

        fun CharSequence.setForegroundColor(color: Int): CharSequence {
            val s = SpannableString(this)
            s.setSpan(ForegroundColorSpan(color), 0, s.length, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE)
            return s
        }

        fun String.safeBoolean(default: Boolean = false) = try {
            toBoolean()
        } catch (e: Exception) {
            default
        }

        fun String.safeByte(default: Byte = 0) = toByteOrNull().safe(default)
        fun String.safeShort(default: Short = 0) = toShortOrNull().safe(default)
        fun String.safeInt(default: Int = 0) = toIntOrNull().safe(default)
        fun String.safeLong(default: Long = 0L) = toLongOrNull().safe(default)
        fun String.safeFloat(default: Float = 0f) = toFloatOrNull().safe(default)
        fun String.safeDouble(default: Double = 0.0) = toDoubleOrNull().safe(default)


        inline fun <reified T> T?.safe(default: T) = this ?: default


        fun String.ifBlank(mapper: () -> String): String =
            if (isBlank()) mapper() else this

        fun String.ifEmpty(mapper: () -> String): String =
            if (isEmpty()) mapper() else this

        fun String?.ifNull(mapper: () -> String): String =
            this ?: mapper()


        /**
         * Take some text, highlight some text with a color and add a click listener to it
         * @param source Text to click
         * @param color Color to change too, default = null,
         * @param onClick Callback
         */
        fun SpannableString.onClick(
            source: String,
            shouldUnderline: Boolean = true,
            shouldBold: Boolean = true,
            color: Int? = null,
            textView: TextView? = null,
            onClick: () -> Unit
        ): SpannableString {
            val startIndex = this.toString().indexOf(source)
            if (startIndex == -1) {
                throw Exception("Cannot highlight this title as $source is not contained with $this")
            }
            this.setSpan(object : ClickableSpan() {
                override fun updateDrawState(ds: TextPaint) {
                    if (color != null) {
                        ds.color = color
                        ds.bgColor = Color.TRANSPARENT
                    }
                }

                override fun onClick(widget: View) {
                    onClick()
                    textView?.clearFocus()
                    textView?.invalidate()
                }
            }, startIndex, startIndex + source.length, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE)
            if (shouldUnderline) {
                this.setSpan(UnderlineSpan(), startIndex, startIndex + source.length, 0)
            }
            if (shouldBold) {
                this.setSpan(StyleSpan(Typeface.BOLD), startIndex, startIndex + source.length, 0)
            }
            return this
        }

        /**
         * Highlight a given word in a string with a given colour
         */
        fun String.highlight(source: String, color: Int): SpannableString {
            val startIndex = this.indexOf(source)
            if (startIndex == -1) {
                throw Exception("Cannot highlight this title as $source is not contained with $this")
            }
            val spannable = SpannableString(this)
            spannable.setSpan(object : ClickableSpan() {
                override fun updateDrawState(ds: TextPaint) {
                    ds.color = color
                }

                override fun onClick(widget: View) {}
            }, startIndex, startIndex + source.length, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE)
            return spannable
        }


        /**
         * If the string is a HTTP URL (ie. Starts with http:// or https://)
         */
        fun String.isHttp(): Boolean {
            return this.matches(Regex("(http|https)://[^\\s]*"))
        }

        /**
         * Convert any string value into it's enum value by a given property of the enum
         */
        inline fun <reified T : Enum<T>> String.toEnum(by: (enum: T) -> String = { it.name }): T? {
            return enumValues<T>().firstOrNull { by(it) == this }
        }


        /***
         * Computes RFC 2104-compliant HMAC signature. This can be used to sign the Amazon S3
         * request urls
         *
         * @param data The data to be signed.
         * @param key  The signing key.
         * @return The Base64-encoded RFC 2104-compliant HMAC signature.
         * @throws java.security.SignatureException when signature generation fails
         */
        @Throws(SignatureException::class)
        fun getHMac(data: String, key: String): String? {

            var result: String? = null
            try {

                @Suppress("LocalVariableName") val HMAC_SHA1_ALGORITHM = "HmacSHA1"

                // get an hmac_sha1 key from the raw key bytes
                val signingKey = SecretKeySpec(key.toByteArray(), HMAC_SHA1_ALGORITHM)

                // get an hmac_sha1 Mac instance &
                // initialize with the signing key
                val mac = Mac.getInstance(HMAC_SHA1_ALGORITHM)
                mac.init(signingKey)

                // compute the hmac on input data bytes
                val digest = mac.doFinal(data.toByteArray())

                if (digest != null) {
                    // Base 64 Encode the results
                    result = Base64.encodeToString(digest, Base64.NO_WRAP)
                }

            } catch (e: Exception) {
                throw SignatureException("Failed to generate HMAC : " + e.message)
            }

            return result
        }

        @Suppress("DEPRECATION")
        fun String.toHtmlSpan(): Spanned = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            Html.fromHtml(this, Html.FROM_HTML_MODE_LEGACY)
        } else {
            Html.fromHtml(this)
        }

        fun Context.getHtmlSpannedString(@StringRes id: Int): Spanned = getString(id).toHtmlSpan()

        fun Context.getHtmlSpannedString(@StringRes id: Int, vararg formatArgs: Any): Spanned =
            getString(id, *formatArgs).toHtmlSpan()

        fun Context.getQuantityHtmlSpannedString(@PluralsRes id: Int, quantity: Int): Spanned =
            resources.getQuantityString(id, quantity).toHtmlSpan()

        fun Context.getQuantityHtmlSpannedString(
            @PluralsRes id: Int,
            quantity: Int,
            vararg formatArgs: Any
        ): Spanned = resources.getQuantityString(id, quantity, *formatArgs).toHtmlSpan()

        fun String.capitalize() =
            replaceFirstChar { if (it.isLowerCase()) it.titlecase(Locale.getDefault()) else it.toString() }


        /**
         * get Application Size in Bytes
         *
         * @property pName the Package Name of the Target Application, Default is Current.
         *
         * Provide Package or will provide the current App Detail
         */
        @Throws(PackageManager.NameNotFoundException::class)
        fun Context.getAppSize(pName: String = packageName): Long {
            return packageManager.getApplicationInfo(pName, 0).sourceDir.asFile().length()
        }

        /**
         * get Application Apk File
         *
         * @property pName the Package Name of the Target Application, Default is Current.
         *
         * Provide Package or will provide the current App Detail
         */
        @Throws(PackageManager.NameNotFoundException::class)
        fun Context.getAppApk(pName: String = packageName): File {
            return packageManager.getApplicationInfo(pName, 0).sourceDir.asFile()
        }

        fun stringConcatenateArrays(first: List<Char>, second: List<Char>): List<Char> {
            var result = ArrayList<Char>(first.size + second.size)
            var j = 0
            for (i in first.indices) i.run {
                result[this] = first[this]
                j = this
            }
            for (k in second.indices) result[k + j + 1] = second[k]
            return result
        }

        fun String.searchForPattern(pattern: String): Int {
            //if the searched text is longer than the original
            if (pattern.length > this.length) return -1
            //if the searched text is null
            if (pattern.isEmpty()) return 0

            for (i in 0 until this.length - pattern.length) {
                var j = i
                while (this[j] == pattern[j - i]) {
                    if ((j - i) + 1 == pattern.length) return i
                    if (j + 1 == this.length) break
                    j++
                }
            }
            return -1
        }

        fun String.removeSymbols(replacement: String = "�"): String {
            return this.replace(Regex("[^\\p{ASCII}‘’]"), replacement)
        }

        fun String.containsAny(vararg strings: String): Boolean {
            return strings.any { this.contains(it) }
        }

        fun String.capitalizeWords(): String {
            return this.split(" ").joinToString(" ") { it.capitalize() }
        }

        fun String.camelCaseWords(): String {
            return this.lowercase().capitalizeWords()
        }

        fun String.trimTo(length: Int): String {
            return if (this.length < length) {
                this
            } else {
                this.substring(0, length - 1).plus("…")
            }
        }

        fun List<String>.containsCaseInsensitive(string: String): Boolean {
            forEach {
                if (it.equals(string, true)) {
                    return true
                }
            }
            return false
        }

        fun List<String>.indexCaseInsensitive(string: String): Int {
            forEachIndexed { index, s ->
                if (s.equals(string, true)) {
                    return index
                }
            }
            return -1
        }

        val arabicChars = charArrayOf('٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩')

        fun String.asArabicNumbers(): String {
            if (TextUtils.isEmpty(this))
                return ""

            val builder = StringBuilder()
            for (i in this.indices) {
                if (Character.isDigit(this[i])) {
                    builder.append(arabicChars[this[i].toInt() - 48])
                } else {
                    builder.append(this[i])
                }
            }
            return "" + builder.toString()
        }

        fun String.parseAssetFile(): Uri = Uri.parse("file:///android_asset/$this")

        fun String.parseInternalStorageFile(absolutePath: String): Uri =
            Uri.parse("$absolutePath/$this")


        fun String.parseFile(): Uri = Uri.fromFile(File(this))

        val Uri.fileExists: Boolean
            get() = File(toString()).exists()


        /**
         * Removes all occurrences of the [value] in the string
         * @param value A vlaue
         * @param ignoreCase Ignore case?
         * @return A new string with all occurrences of the [value] removed
         */
        fun String.remove(value: String, ignoreCase: Boolean = false): String =
            replace(value, "", ignoreCase)

        /**
         * Removes decimal number format symbol
         * @return A new string without `,`
         */
        fun String.removeNumberFormat(): String = remove(",")


        /**
         * Removes decimal number format symbol
         * @return A new string without `,`
         */
        fun String.removeNumberFormatDot(): String = remove(".")

        /** The Char array representing by this string */
        inline val String.ch: Array<Char> get() = this.toCharArray().toTypedArray()

        fun String?.strikeThrough() = this?.let {
            SpannableString(it).apply {
                setSpan(
                    StrikethroughSpan(),
                    0,
                    it.length,
                    Spanned.SPAN_EXCLUSIVE_EXCLUSIVE
                )
            }
        }


        fun String.abbreviateMiddle(middle: String, length: Int): String {
            val str = this

            if (this.isEmpty()) {
                return this
            }

            if (length >= str.length || length < middle.length + 2) {
                return this
            }

            val targetSting = length - middle.length
            val startOffset = targetSting / 2 + targetSting % 2
            val endOffset = str.length - targetSting / 2

            val builder = StringBuilder(length)
            builder.append(str.substring(0, startOffset))
            builder.append(middle)
            builder.append(str.substring(endOffset))

            return builder.toString()
        }


        val NON_DIGIT_REGEX = Regex("[^A-Za-z0-9]")
        val DIGIT_REGEX = Regex("[^0-9]")

        fun String?.replaceNonDigit(replacement: String = "") =
            this?.replace(NON_DIGIT_REGEX, replacement)

        fun String?.replaceDigit(replacement: String = "") = this?.replace(DIGIT_REGEX, replacement)

        fun String.isValidEmail() = Patterns.EMAIL_ADDRESS.matcher(this).matches()

        fun String?.isInt(): Boolean {
            if (isNullOrBlank()) return false
            return try {
                this?.toIntOrNull() != null
            } catch (exc: ParseException) {
                false
            }
        }

        fun String.removeSpace(): String = replace(" ", "")

        fun String.toDate(format: DateFormat): Date? {
            return try {
                format.parse(this)
            } catch (exc: ParseException) {
                exc.printStackTrace()
                null
            }
        }

        fun String.getRequestUrl(vararg fields: Pair<String, Any>): String {

            val param = StringBuffer()
            for (item in fields) {
                param.append(
                    item.first + "=" + URLEncoder.encode(
                        item.second.toString(),
                        "UTF-8"
                    ) + "&"
                )
            }
            val paramStr = param.toString().let {
                it.substring(0, it.length - 1)
            }
            return if (indexOf("?") >= 0) {
                "$this&$paramStr"
            } else {
                "$this?$paramStr"
            }
        }


        fun String.remove(@RegExp pattern: String) = remove(Regex(pattern, RegexOption.IGNORE_CASE))

        fun String.remove(regex: Regex) = replace(regex, "")

        fun String.capitalizeFirstLetter(): String {
            return this.substring(0, 1).uppercase() + this.substring(1)
        }

        fun String?.openInBrowser(context: Context?) {
            if (this != null && this.isNotEmpty()) {
                val page = Uri.parse(this)
                val intent = Intent(Intent.ACTION_VIEW, page)

                context?.apply {
                    tryOrElse {
                        context.startActivity(intent)
                    }
                }

            }
        }

        fun String.removeSpaces(): String {
            return this.replace(" ", "")
        }

        fun String.versionNumberToInt(): Int {
            return split(".").joinToString("").toInt()
        }

        fun String.capitalizeFirstLetterEachWord(): String {
            return this.lowercase()
                .split(" ")
                .joinToString(" ") { it.capitalize() }
        }

        fun String.toColor(): Int? {
            return if (this.isNotEmpty()) {
                Color.parseColor(this)
            } else {
                null
            }
        }

    }


}