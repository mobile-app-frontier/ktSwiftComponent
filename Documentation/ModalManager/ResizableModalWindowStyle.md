# ResizableModalWindowStyle

``` swift
public struct ResizableModalWindowStyle : ModalWindowStyle 
```

## Inheritance

[`ModalWindowStyle`](/Documentation/ModalManager/ModalWindowStyle)

## Initializers

### `init()`

``` swift
public init() 
```

### `init(windowWidth:windowHeight:windowBackGround:windowForeGround:windowPadding:)`

``` swift
public init(
        windowWidth: CGFloat,
        windowHeight: CGFloat,
        windowBackGround: Color,
        windowForeGround: Color,
        windowPadding: EdgeInsets
    ) 
```

## Properties

### `windowWidth`

``` swift
public var windowWidth: CGFloat = 300
```

### `windowHeight`

``` swift
public var windowHeight: CGFloat = 200
```

### `windowBackGround`

``` swift
public var windowBackGround: Color = .white
```

### `windowForeGround`

``` swift
public var windowForeGround: Color = .black
```

### `windowPadding`

``` swift
public var windowPadding: EdgeInsets 
```

### `windowCornerRadius`

``` swift
public var windowCornerRadius: CGFloat = 10
```

### `windowShadow`

``` swift
public var windowShadow: CGFloat = 5
```

### `windowFont`

``` swift
public var windowFont: Font 
```
