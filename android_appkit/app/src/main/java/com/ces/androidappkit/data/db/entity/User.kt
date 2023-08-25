package com.ces.androidappkit.data.db.entity

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "user")
data class User(
    val email: String?,
    val firstName: String?,
    @PrimaryKey val id: String,
    val lastName: String?,
    val mobilePhone: String?,
    val username: String?
)