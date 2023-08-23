# StepContent

스탭의 내부 컨텐츠 항목

``` swift
public struct StepContent<T>: Identifiable 
```

## Inheritance

`Equatable`, `Identifiable`

## Initializers

### `init(step:content:)`

``` swift
public init(step:T, content: @escaping () -> AnyView) 
```

## Properties

### `step`

``` swift
public let step: T
```

### `id`

``` swift
public let id: UUID 
```

## Operators

### `==`

``` swift
public static func == (lhs: StepContent, rhs: StepContent) -> Bool 
```
