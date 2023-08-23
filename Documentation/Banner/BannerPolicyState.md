# BannerPolicyState

``` swift
public enum BannerPolicyState 
```

## Enumeration Cases

### `initial`

`initial`:​ 초기 상태

``` swift
case initial
```

### `fetched`

`fetched`:​ remoteBannerPolicy 와 localBannerPolicy 를 fetch 완료한 상태.

``` swift
case fetched(remoteBanner: BannerPolicy, localBanner: LocalBannerPolicy)
```

### `success`

`success`:​ remoteBannerPolicy 와 localBannerPolicy 를 비교하여 보여줄 배너를 filtering 완료한 상태.

``` swift
case success(willShowBanner: BannerPolicy)
```

### `fail`

`fail`:​ errpr 가 발생하여 fail 한 상태.

``` swift
case fail(Error)
```

## Properties

### `willShowBanner`

`success` 상태에서만 willShowBanner return. 이외의 상태에서는 nil 을 return.

``` swift
public var willShowBanner: BannerPolicy? 
```
