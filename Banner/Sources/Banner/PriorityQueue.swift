//
//  PriorityQueue.swift
//  GeniePhone
//
//  Created by 이소정 on 2023/04/10.
//

import Foundation

// https://jeonyeohun.tistory.com/327
public struct PriorityQueue<T: Comparable> {
    public var heap: Heap<T>
    
    public init(_ elements: [T] = [], _ sort: @escaping (T, T) -> Bool) {
        heap = Heap(elements: elements, sortFunction: sort)
    }
    
    public var count : Int {
        return heap.count
    }
    public var isEmpty : Bool {
        return heap.isEmpty
    }
    
    public func top() -> T? {
        return heap.peek
    }
    
    public mutating func clear () {
        while !heap.isEmpty {
            _ = heap.remove()
        }
    }
    
    public mutating func pop() -> T? {
        return heap.remove()
    }
    
    public mutating func push(_ element: T) {
        heap.insert(node: element)
    }
}
