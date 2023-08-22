# InfiniteScrollDelegate

InfiniteScrollModifier 생성 시에 속성을 정의합니다.

``` swift
public struct InfiniteScrollDelegate 
```

## Initializers

### `init(pullToRefresh:fetchMore:refreshProgressView:infiniteProgressView:)`

``` swift
public init(
        pullToRefresh: ( () async-> Void)? = nil,
        fetchMore: ( () async-> Void)? = nil,
        refreshProgressView: (() -> any View)? = nil,
        infiniteProgressView: (() -> any View)? = nil
    ) 
```
