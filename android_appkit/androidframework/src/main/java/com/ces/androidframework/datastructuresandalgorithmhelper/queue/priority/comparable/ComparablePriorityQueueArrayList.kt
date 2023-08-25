package com.ces.androidframework.datastructuresandalgorithmhelper.queue.priority.comparable

import com.ces.androidframework.datastructuresandalgorithmhelper.queue.priority.AbstractPriorityQueueArrayList

class ComparablePriorityQueueArrayList<T : Comparable<T>> :
    AbstractPriorityQueueArrayList<T>() {

    override val isEmpty: Boolean
        get() = elements.isEmpty()

    override fun sort() {
        elements.sort()
    }
}