package com.ces.androidappkit.data.db.dao

import androidx.room.*
import com.ces.androidappkit.data.db.entity.User
import kotlinx.coroutines.flow.Flow

@Dao
interface UserDao {

    @Query("SELECT * FROM user")
    fun getUsers(): Flow<List<User>>

    @Query("SELECT * FROM user WHERE id = :id")
    suspend fun getUserById(id: String): User?

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertUser(user: User)

    @Delete
    suspend fun deleteUser(user: User)

    @Query("DELETE FROM user")
    fun delete()

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun saveUsers(users: List<User>)
}