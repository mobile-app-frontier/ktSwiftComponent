//
//  PriorityQueue.swift
//  GeniePhone
//
//  Created by 이소정 on 2023/04/10.
//

import Foundation

// https://jeonyeohun.tistory.com/327
public struct PriorityQueue<T: Comparable> {
    internal var heap: Heap<T>
    
    internal init(_ elements: [T] = [], _ sort: @escaping (T, T) -> Bool) {
        heap = Heap(elements: elements, sortFunction: sort)
    }
    
    internal var count : Int {
        return heap.count
    }
    internal var isEmpty : Bool {
        return heap.isEmpty
    }
    
    internal func top() -> T? {
        return heap.peek
    }
    
    internal mutating func clear () {
        while !heap.isEmpty {
            _ = heap.remove()
        }
    }
    
    internal mutating func pop() -> T? {
        return heap.remove()
    }
    
    internal mutating func push(_ element: T) {
        heap.insert(node: element)
    }
}
