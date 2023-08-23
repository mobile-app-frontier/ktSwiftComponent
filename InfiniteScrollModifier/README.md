# InfiniteScrollModifier

Module description

- [Example](#example)
- [structure](#structure)

## Example

``` Swift
// Code block
struct SampleView: View {
    var body = {
        VStack {

        }
    }
}
```

## Structure

| name | param | return | Description |
| :--- | :---: | ---: | --- |
| getIndex | Void | Int | get index |
| setIndex | Int | Void | set index |


Link [Link](https://google.com)

> **NOTE:** \
hello note 


## [MORE](/Documentation/InfiniteScrollModifier/Home.md)


A description of this package.


public struct InfiniteScrollExampleView: View {
    
    @State var data: [String] = []
    
    public init() {}
    
    public var body: some View {
        LazyVStack {
            ForEach(data, id: \.self) { item in
                VStack {
                    Text(item)
                    Text(item)
                }
            }
        }
        /// 상단 새로고침 및 하단 불러오기를 트리거하려면 InfiniteScrollModifier를 호출합니다.
        .modifier(
            InfiniteScrollModifier(
                delegate: InfiniteScrollDelegate(
                    pullToRefresh: onRefresh,
                    fetchMore: fetchMore
                )
            )
        )
    }
    
    func fetchMore() async {
        do {
            try await Task.sleep(nanoseconds: 2_000_000_000)
            let result = ["4","5","6"]
            data += result
        } catch {
            
        }
    }
    
    func onRefresh() async {
        do {
            try await Task.sleep(nanoseconds: 2_000_000_000)
            let str = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            var arr: [String] = []
            (0..<19).forEach { number in
                arr.append(str.createRandomStr(length: number))
            }
            data = arr
        } catch {
            
        }
    }
}

extension String {
    
    func createRandomStr(length: Int) -> String {
        let str = (0 ..< length).map{ _ in self.randomElement()! }
        return String(str)
    }
    
}
