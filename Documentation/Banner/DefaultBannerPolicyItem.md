# DefaultBannerPolicyItem

``` swift
public struct DefaultBannerPolicyItem: BannerPolicyItem 
```

## Inheritance

[`BannerPolicyItem`](./BannerPolicyItem)

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

`content`:​ Banner content. image 타입만 존재

``` swift
public let content: DefaultBannerPolicyItem.Content
```

### `category`

`category`:​ Banner 가 속하는 category. category 별로 배너를 모아서 보여줌.

``` swift
public let category: String
```

## Operators

### `<`

``` swift
public static func < (lhs: DefaultBannerPolicyItem, rhs: DefaultBannerPolicyItem) -> Bool 
```

### `==`

``` swift
public static func == (lhs: DefaultBannerPolicyItem, rhs: DefaultBannerPolicyItem) -> Bool 
```
