# ShimmerModifier

A view modifier that applies an animated "shimmer" to any view, typically to show that
an operation is in progress.

``` swift
public struct ShimmerModifier: ViewModifier 
```

## Inheritance

`ViewModifier`

## Initializers

### `init(animation:)`

Initializes his modifier with a custom animation,

``` swift
public init(animation: Animation = Self.defaultAnimation) 
```

#### Parameters

  - animation: A custom animation. The default animation is `.linear(duration: 1.5).repeatForever(autoreverses: false)`.

### `init(duration:bounce:delay:)`

Convenience, backward-compatible initializer.

``` swift
public init(duration: Double = 1.5, bounce: Bool = false, delay: Double = 0) 
```

#### Parameters

  - duration: The duration of a shimmer cycle in seconds. Default: `1.5`.
  - bounce: Whether to bounce (reverse) the animation back and forth. Defaults to `false`.
  - delay: A delay in seconds. Defaults to `0`.

## Properties

### `defaultAnimation`

The default animation effect.

``` swift
public static let defaultAnimation 
```

## Methods

### `body(content:)`

``` swift
public func body(content: Content) -> some View 
```
