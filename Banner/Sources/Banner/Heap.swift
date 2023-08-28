//
//  heap.swift
//  GeniePhone
//
//  Created by 이소정 on 2023/04/10.
//

import Foundation

// https://jeonyeohun.tistory.com/325
public struct Heap<T: Comparable> {
    private var elements: [T] = []
    private let sortFunction: (T, T) -> Bool
    
    internal var isEmpty: Bool {
        return self.elements.count <= 1
    }
    internal var peek: T? {
        if self.isEmpty { return nil }
        return self.elements.last!
    }
    internal var count: Int {
        return self.elements.count - 1
    }
    
    internal init(elements: [T] = [], sortFunction: @escaping (T, T) -> Bool) {
        if !elements.isEmpty {
            self.elements = [elements.first!] + elements
        } else {
            self.elements = elements
        }
        self.sortFunction = sortFunction
        if elements.count > 1 {
            self.buildHeap()
        }
    }
    
    internal func leftChild(of index: Int) -> Int {
        return index * 2
    }
    
    internal func rightChild(of index: Int) -> Int {
        return index * 2 + 1
    }
    
    internal func parent(of index: Int) -> Int {
        return (index) / 2
    }
    
    internal mutating func add(element: T) {
        self.elements.append(element)
    }
    
    internal mutating func diveDown(from index: Int) {
        var higherPriority = index
        let leftIndex = self.leftChild(of: index)
        let rightIndex = self.rightChild(of: index)
        
        if leftIndex < self.elements.endIndex && self.sortFunction(self.elements[leftIndex], self.elements[higherPriority]) {
            higherPriority = leftIndex
        }
        if rightIndex < self.elements.endIndex && self.sortFunction(self.elements[rightIndex], self.elements[higherPriority]) {
            higherPriority = rightIndex
        }
        if higherPriority != index {
            self.elements.swapAt(higherPriority, index)
            self.diveDown(from: higherPriority)
        }
    }
    
    internal mutating func swimUp(from index: Int) {
        var index = index
        while index != 1 && self.sortFunction(self.elements[index], self.elements[self.parent(of: index)]) {
            self.elements.swapAt(index, self.parent(of: index))
            index = self.parent(of: index)
        }
    }
    
    internal mutating func buildHeap() {
        for index in (1...(self.elements.count / 2)).reversed() {
            self.diveDown(from: index)
        }
    }
    
    internal mutating func insert(node: T) {
        if self.elements.isEmpty {
            self.elements.append(node)
        }
        self.elements.append(node)
        self.swimUp(from: self.elements.endIndex - 1)
    }
    
    internal mutating func remove() -> T? {
        if self.isEmpty { return nil }
        
        self.elements.swapAt(1, elements.endIndex - 1)
        
        let deleted = elements.removeLast()
        self.diveDown(from: 1)
        
        return deleted
    }
}

