# Extensions on View

## Methods

### `animateVisible(visible:)`

animate view's visible

``` swift
@ViewBuilder
    func animateVisible(visible: Bool) -> some View 
```

#### Parameters

  - visible: view's visible condition

### `shimmering(active:duration:bounce:delay:)`

Adds an animated shimmering effect to any view, typically to show that
an operation is in progress.

``` swift
@ViewBuilder func shimmering(
        active: Bool = true, duration: Double = 1.5, bounce: Bool = false, delay: Double = 0
    ) -> some View 
```

#### Parameters

  - active: Convenience parameter to conditionally enable the effect. Defaults to `true`.
  - duration: The duration of a shimmer cycle in seconds. Default: `1.5`.
  - bounce: Whether to bounce (reverse) the animation back and forth. Defaults to `false`.
  - delay: A delay in seconds. Defaults to `0`.

### `shimmering(active:animation:)`

Adds an animated shimmering effect to any view, typically to show that
an operation is in progress.

``` swift
@ViewBuilder func shimmering(active: Bool = true, animation: Animation = ShimmerModifier.defaultAnimation) -> some View 
```

#### Parameters

  - active: Convenience parameter to conditionally enable the effect. Defaults to `true`.
  - animation: A custom animation. The default animation is `.linear(duration: 1.5).repeatForever(autoreverses: false)`.
