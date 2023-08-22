# Heap

``` swift
public struct Heap<T: Comparable> 
```

## Initializers

### `init(elements:sortFunction:)`

``` swift
public init(elements: [T] = [], sortFunction: @escaping (T, T) -> Bool) 
```

## Properties

### `isEmpty`

``` swift
public var isEmpty: Bool 
```

### `peek`

``` swift
public var peek: T? 
```

### `count`

``` swift
public var count: Int 
```

## Methods

### `leftChild(of:)`

``` swift
public func leftChild(of index: Int) -> Int 
```

### `rightChild(of:)`

``` swift
public func rightChild(of index: Int) -> Int 
```

### `parent(of:)`

``` swift
public func parent(of index: Int) -> Int 
```

### `add(element:)`

``` swift
public mutating func add(element: T) 
```

### `diveDown(from:)`

``` swift
public mutating func diveDown(from index: Int) 
```

### `swimUp(from:)`

``` swift
public mutating func swimUp(from index: Int) 
```

### `buildHeap()`

``` swift
public mutating func buildHeap() 
```

### `insert(node:)`

``` swift
public mutating func insert(node: T) 
```

### `remove()`

``` swift
public mutating func remove() -> T? 
```
