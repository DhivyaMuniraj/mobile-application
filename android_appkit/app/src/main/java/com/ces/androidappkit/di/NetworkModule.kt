package com.ces.androidappkit.di


import androidx.multidex.BuildConfig
import com.ces.androidappkit.util.Urls
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import javax.inject.Qualifier
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
class NetworkModule {

    @Qualifier
    @Retention(AnnotationRetention.BINARY)
    annotation class BaseUrlRetrofit

    // Provides Base Url, Picks up the data from the flavor respectively
    @BaseUrlRetrofit
    @Provides
    fun providesBaseUrl() = Urls.APP_BASE_URL

    // Logging interceptor
    @Provides
    fun providesOkHttpClient(): OkHttpClient {
        val okHttpClient = OkHttpClient.Builder()
        if (BuildConfig.DEBUG) {
            val loggingInterceptor = HttpLoggingInterceptor()
            loggingInterceptor.setLevel(HttpLoggingInterceptor.Level.BODY)
            okHttpClient
                .addInterceptor(loggingInterceptor)

        }
        return okHttpClient.build()
    }


    //Provides the Retrofit Instance
    @Singleton
    @Provides
    fun providesRetrofit(okHttpClient: OkHttpClient, @BaseUrlRetrofit baseUrl: String): Retrofit =
        Retrofit.Builder()
            .addConverterFactory(GsonConverterFactory.create())
            .baseUrl(baseUrl)
            .client(okHttpClient)
            .build()

}