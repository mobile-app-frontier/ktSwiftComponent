# InfiniteScrollModifier

View에 modifier 형태로 붙여서 사용할 수 있는 Pull to refresh 및 Infinite scrolling를 제공한다.

- [Example](#example)
- [Structure](#structure)
- [More](#more)

## Example
``` Swift
LazyVStack {
    // content ...
}
.modifier(
    InfiniteScrollModifier(
        delegate: InfiniteScrollDelegate(
            pullToRefresh: onRefresh,
            fetchMore: fetchMore
        )
    )
)
```

## Structure
### InfiniteScrollModifier
| name | param | return | Description |
| :--- | :---: | ---: | --- |
| delegate | InfiniteScrollDelegate | Void | modifier의 속성 정의 |

### InfiniteScrollDelegate
| pullToRefresh | Void | (() async -> Void)? | pull to refresh 시 수행할 콜백 등록 |
| fetchMore | Void | (() async -> Void)? | infinite scroll 시 수행할 콜백 등록 |
| refreshProgressView | Void | (() -> any View)? | pull to refresh 시 띄울 progress view |
| infiniteProgressView | Void | (() -> any View)? | infinite scroll 시 띄울 progress view |

## [MORE]
