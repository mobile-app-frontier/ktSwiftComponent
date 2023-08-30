# InfiniteScrollModifier

View에 modifier 형태로 붙여서 사용할 수 있는 Pull to refresh 및 Infinite scrolling를 제공합니다.

### `Pull To Refresh 또는 Infinite Scrolling 사용하기`
해당 기능을 추가하고자 하는 SwiftUI View에 InfiniteScrollModifier를 달아줍니다.
InfiniteScrollModifier가 가지고 있는 InfiniteScrollDelegate를 정의하여 사용할 수 있으며, 아래와 같은 요소들을 정의해줄 수 있습니다.
- pull To Refresh 또는 Infinite Scrolling 시 트리거 할 동작 정의 (미정의 시 사용하지 않는 것으로 봅니다.)
- pull To Refresh 또는 Infinite Scrolling 동작 시 화면에 표출할 View 정의 (미정의 시 디폴트 프로그래스 뷰를 사용합니다.)

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

## MORE
