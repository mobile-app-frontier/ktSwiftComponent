# BannerPolicyItemModel

``` swift
public struct BannerPolicyItemModel: Codable 
```

## Inheritance

`Codable`

## Properties

### `id`

`id`:​ Banner Id

``` swift
public let id: String
```

### `priority`

`priority`:​ Banner 우선순위. 우선순위가 높을수록 먼저 보여줌.

``` swift
public let priority: Int
```

### `contentType`

`contentType`:​ Popup Banner 는`I(image)`,`T(text)`, `H(html)`. Default Banner 는 `image`타입만 제공.

``` swift
public let contentType: String
```

### `content`

`content`:​ contentType 이  `image` 일 경우에는 imageUrl. `text`:​ content 내용. `html`:​ HTML 전문.

``` swift
public let content: String
```

### `landingType`

`landingType`:​  landing 할 화면. landing 하지 않을 경우, nil.

``` swift
public let landingType: String?
```

### `landingDestination`

`landingDestination`:​ landingType 이 url 일 경우, 이동할 web view url.

``` swift
public let landingDestination: String?
```

### `closeType`

`closeType`:​ PopupBanner 에서 사용. `close`:​ 닫기. 한번보여주고 다시 보여주지 않음. `never`:​ 다시보지않기. `week`:​ 일주일동안 보지않기. `today`:​ 오늘은 보지 않기.

``` swift
public let closeType: String?
```

### `appVersion`

`appVersion`:​ 해당 배너를 보여줄 AppVersion. nil 일 경우 모든 버전에서 보여짐.

``` swift
public let appVersion: String?
```

### `category`

`category`:​ Default Banner 에서 사용. Default Banner 일 경우, type 별로 BannerPolicyItem 을 묶어 제공.

``` swift
public let category: String?
```

### `type`

`type`:​ `popup`:​ popup 배너 `default`:​ 일반 배너.

``` swift
public let type: String
```

### `additionalInfo`

`additionalInfo`:​ extra format.

``` swift
public let additionalInfo: [String: String]?
```
