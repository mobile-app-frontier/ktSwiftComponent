# AnimationView

SwiftUI View의 animation을 줄 수 있는 기능을 포함한다.

## Support Animation 

[1. AnimateVisibleView](#1-animatevisibleview) : change visible by animation \
[2. ShimmerModifier](#2-shimmermodifier) : append shimmer effect in view   

### 1. AnimateVisibleView

#### description
화면에 특정 view가 노출을 즉시 시켜주는 방식이 아닌 animation을 주는 방식.

#### Example
``` Swift

Text("test text")
    .animateVisible(visible: true)
    
```

### 2. ShimmerModifier


#### Example

``` Swift
// default animation timing 사용 
Text("test text")
    .shimmering()
        
```


## [More](../Documentation/AnimationView/Home.md)
