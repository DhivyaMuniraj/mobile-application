package com.ces.androidappkit.util

class Constants {

    companion object {

        class AppConstants {
            companion object {
                const val TAG = "APP_TAG"
            }

            enum class ApiContext {
                CONDITION_ONE, CONDITION_TWO
            }
        }

        class DateTimeConstants {
            companion object {
                const val DATE_FORMAT_GENERIC = "dd, MMM, yyyy"
                const val DATE_FORMAT_US = "MM/dd/yyyy"
                const val DATE_ISO_FORMAT_ONE = "yyyy-MM-dd'T'HH:mm:ss"
                const val DATE_ISO_FORMAT_TWO = "yyyy-MM-dd'T'HH:mm:ss.SSS"
                const val DATE_ISO_FORMAT_WITH_ZONE = "yyyy-MM-dd'T'HH:mm:ss'Z'"
            }
        }

        class ResponseCodes {
            companion object {
                const val RESPONSE_SUCCESS = 200
                const val RESPONSE_DATA_SUBMITTED = 204
                const val RESPONSE_VALIDATION_ERRORS = 400
                const val RESPONSE_UNAUTHORIZED_ERROR = 401
                const val RESPONSE_RESOURCE_NOT_FOUND = 404
                const val RESPONSE_INTERNAL_ERROR = 500
            }
        }

        class EventConstants {
            companion object {
                const val APP_EVENT_RECEIVER = "EVENT_RECEIVER"
                const val APP_EVENT_TYPE = "EVENT_TYPE"
                const val APP_EVENT_MESSAGE = "EVENT_MESSAGE"

                //ADD YOUR CUSTOM EVENTS HERE
                const val APP_GET_ALL_CALLED = "GET_ALL_CALLED"
            }
        }

        class UiStateConstants {
            companion object {
                const val FIELD_DEFAULT_WITH_PLACE_HOLDER = "FIELD_DEFAULT_WITH_PLACE_HOLDER"
                const val FIELD_FILLED = "FIELD_FILLED"
                const val FIELD_TYPING = "FIELD_TYPING"
                const val FIELD_SUCCESS = "FIELD_SUCCESS"
                const val FIELD_ERROR = "FIELD_ERROR"
                const val FIELD_DISABLED = "FIELD_DISABLED"
                const val FIELD_WITH_CAPTION = "FIELD_WITH_CAPTION"
            }
        }

    }
}