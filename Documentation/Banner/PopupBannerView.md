# PopupBannerView

PopupBannerView. Content 높이에 따라서 View 를 보여줌.
실제 bottom sheet 처럼 보여주기 위해서는 해당 View 를 present 할 때 UIViewController 의 배경색을 투명하게 혹은 dim 처리된 색상으로 변경하고, UIModalPresentationStyle 을 .overCurrentContext 로 지정해주어야 함.

``` swift
public struct PopupBannerView: View 
```

## Inheritance

`View`

## Initializers

### `init(banner:)`

``` swift
public init(banner: PopupBannerPolicyItem) 
```

## Properties

### `body`

``` swift
public var body: some View 
```
