package com.ces.androidframework.datastructuresandalgorithmhelper.queue.priority.comparable

import com.ces.androidframework.datastructuresandalgorithmhelper.heap.ComparableHeap
import com.ces.androidframework.datastructuresandalgorithmhelper.heap.Heap
import com.ces.androidframework.datastructuresandalgorithmhelper.queue.priority.AbstractPriorityQueue

class ComparablePriorityQueue<T : Comparable<T>> : AbstractPriorityQueue<T>() {
    override val heap: Heap<T> = ComparableHeap()

    override val isEmpty: Boolean
        get() = heap.isEmpty
}