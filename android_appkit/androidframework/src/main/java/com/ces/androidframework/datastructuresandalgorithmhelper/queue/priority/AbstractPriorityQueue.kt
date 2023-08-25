package com.ces.androidframework.datastructuresandalgorithmhelper.queue.priority

import com.ces.androidframework.datastructuresandalgorithmhelper.heap.Heap
import com.ces.androidframework.datastructuresandalgorithmhelper.queue.Queue

abstract class AbstractPriorityQueue<T> : Queue<T> {

    abstract val heap: Heap<T>

    override fun enqueue(element: T): Boolean {
        heap.insert(element)
        return true
    }

    override fun dequeue(): T? = heap.remove()

    override val count: Int
        get() = heap.count

    override fun peek(): T? = heap.peek()

}