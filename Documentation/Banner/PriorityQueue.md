# PriorityQueue

``` swift
public struct PriorityQueue<T: Comparable> 
```

## Initializers

### `init(_:_:)`

``` swift
public init(_ elements: [T] = [], _ sort: @escaping (T, T) -> Bool) 
```

## Properties

### `heap`

``` swift
public var heap: Heap<T>
```

### `count`

``` swift
public var count : Int 
```

### `isEmpty`

``` swift
public var isEmpty : Bool 
```

## Methods

### `top()`

``` swift
public func top() -> T? 
```

### `clear()`

``` swift
public mutating func clear () 
```

### `pop()`

``` swift
public mutating func pop() -> T? 
```

### `push(_:)`

``` swift
public mutating func push(_ element: T) 
```
