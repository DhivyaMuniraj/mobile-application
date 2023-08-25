package com.ces.androidframework.datastructuresandalgorithmhelper.search

/**
 * Plain list stringSearch.
 * Goes through every single element and finds the index of the value by comparing the current element in the loop
 * with the value.
 *
 * Time complexity per case:
 *      Best - O(1), constant. In case the element is on the first place
 *      Average, Worst - O(n), linear.
 *      Use kotlin's find function for such case
 */
fun <T> plainSearch(list: List<T>, value: T): Int {
    for (i in list.indices) if (list[i] == value) return i
    return -1
}

