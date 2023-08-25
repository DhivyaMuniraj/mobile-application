package com.ces.androidframework.datastructuresandalgorithmhelper.queue


import java.util.*

fun <T> Queue<T>.reverse() {
    val stack = Stack<T>()
    var next = this.dequeue()
    while (next != null) {
        stack.push(next)
        next = this.dequeue()
    }
    next = stack.pop()
    while (next != null) {
        this.enqueue(next)
        next = stack.pop()
    }
}