package com.ces.androidframework.datastructuresandalgorithmhelper.graphs.prim

import com.ces.androidframework.datastructuresandalgorithmhelper.graphs.Edge
import com.ces.androidframework.datastructuresandalgorithmhelper.graphs.EdgeType
import com.ces.androidframework.datastructuresandalgorithmhelper.graphs.Graph
import com.ces.androidframework.datastructuresandalgorithmhelper.graphs.Vertex
import com.ces.androidframework.datastructuresandalgorithmhelper.graphs.adjacency.AdjacencyList
import com.ces.androidframework.datastructuresandalgorithmhelper.queue.priority.AbstractPriorityQueue
import com.ces.androidframework.datastructuresandalgorithmhelper.queue.priority.comparator.ComparatorPriorityQueue
import kotlin.math.roundToInt


object Prim {

    private fun <T> addAvailableEdges(
        vertex: Vertex<T>,
        graph: Graph<T>,
        visited: Set<Vertex<T>>,
        priorityQueue: AbstractPriorityQueue<Edge<T>>
    ) {
        graph.edges(vertex).forEach { edge ->
            if (edge.destination !in visited) {
                priorityQueue.enqueue(edge)
            }
        }
    }

    fun <T> produceMinimumSpanningTree(graph: AdjacencyList<T>): Pair<Double, AdjacencyList<T>> {
        var cost = 0.0
        val adjacencyList = AdjacencyList<T>()
        val visited = mutableSetOf<Vertex<T>>()
        val comparator = Comparator<Edge<T>> { first, second ->
            val firstWeight = first.weight ?: 0.0
            val secondWeight = second.weight ?: 0.0
            (secondWeight - firstWeight).roundToInt()
        }
        val priorityQueue = ComparatorPriorityQueue(comparator)
        adjacencyList.copyVertices(graph)

        val start = graph.allVertices.firstOrNull() ?: return Pair(cost, adjacencyList)

        visited.add(start)
        addAvailableEdges(start, graph, visited, priorityQueue)

        while (true) {
            val smallestEdge = priorityQueue.dequeue() ?: break
            val vertex = smallestEdge.destination
            if (vertex in visited) continue
            visited.add(vertex)
            cost += smallestEdge.weight ?: 0.0
            adjacencyList.add(
                EdgeType.UNDIRECTED,
                smallestEdge.source,
                smallestEdge.destination,
                smallestEdge.weight
            )
            addAvailableEdges(vertex, graph, visited, priorityQueue)
        }

        return Pair(cost, adjacencyList)
    }

}
