package com.ces.androidframework.datastructuresandalgorithmhelper.heap

interface Heap<T> : Collection<T> {
    fun peek(): T?
    fun getNthSmallestT(n: T): T?

    fun merge(heap: AbstractHeap<T>)

    fun isMinHeap(): Boolean
}