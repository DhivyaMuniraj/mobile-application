package com.ces.androidframework.datastructuresandalgorithmhelper.queue.priority

import com.ces.androidframework.datastructuresandalgorithmhelper.queue.Queue

abstract class AbstractPriorityQueueArrayList<T> : Queue<T> {
    protected val elements = ArrayList<T>()
    abstract fun sort()
    override val count: Int
        get() = elements.count()

    override fun peek(): T? = elements.firstOrNull()

    override fun dequeue(): T? = elements.removeFirstOrNull()

    override fun enqueue(element: T): Boolean {
        elements.add(element)
        sort()
        return true
    }

    override fun toString() = elements.toString()


}