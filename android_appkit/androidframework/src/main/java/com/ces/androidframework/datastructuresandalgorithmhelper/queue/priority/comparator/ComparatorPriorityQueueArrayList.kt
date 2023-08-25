package com.ces.androidframework.datastructuresandalgorithmhelper.queue.priority.comparator

import com.ces.androidframework.datastructuresandalgorithmhelper.queue.priority.AbstractPriorityQueueArrayList
import java.util.*

class ComparatorPriorityQueueArrayList<T>(private val comparator: Comparator<T>) :
    AbstractPriorityQueueArrayList<T>() {

    override val isEmpty: Boolean
        get() = elements.isEmpty()

    override fun sort() {
        Collections.sort(elements, comparator)
    }
}