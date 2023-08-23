# PopupBannerPolicyItem

``` swift
public struct PopupBannerPolicyItem: BannerPolicyItem 
```

## Inheritance

[`BannerPolicyItem`](/Documentation/Banner/BannerPolicyItem)

## Initializers

### `init(from:)`

``` swift
public init(from model: BannerPolicyItemModel) 
```

## Properties

### `id`

BannerPolicyItem protocol.

``` swift
public let id: String
```

### `priority`

``` swift
public let priority: Int
```

### `targetAppversion`

``` swift
public let targetAppversion: Version?
```

### `landingType`

``` swift
public let landingType: BannerLandingType
```

### `additionalInfo`

``` swift
public let additionalInfo: [String : String]?
```

### `content`

`content`:​ Banner Content. text / html / image

``` swift
public let content: PopupBannerPolicyItem.Content
```

### `closeType`

`closeType`:​ Banner 가 닫히는 옵션. closeOnly / nerverShowAgain / notShowForWeek / notShowToday

``` swift
public let closeType: BannerCloseType
```

## Operators

### `==`

``` swift
public static func == (lhs: PopupBannerPolicyItem, rhs: PopupBannerPolicyItem) -> Bool 
```

### `<`

``` swift
public static func < (lhs: PopupBannerPolicyItem, rhs: PopupBannerPolicyItem) -> Bool 
```
