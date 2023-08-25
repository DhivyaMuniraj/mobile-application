package com.ces.androidframework.datastructuresandalgorithmhelper.queue.priority.comparator

import com.ces.androidframework.datastructuresandalgorithmhelper.heap.ComparatorHeap
import com.ces.androidframework.datastructuresandalgorithmhelper.heap.Heap
import com.ces.androidframework.datastructuresandalgorithmhelper.queue.priority.AbstractPriorityQueue

class ComparatorPriorityQueue<T>(comparator: Comparator<T>) : AbstractPriorityQueue<T>() {
    override val heap: Heap<T> = ComparatorHeap(comparator)

    override val isEmpty: Boolean
        get() = heap.isEmpty
}