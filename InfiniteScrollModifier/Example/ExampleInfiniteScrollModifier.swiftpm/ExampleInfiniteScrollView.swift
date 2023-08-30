import SwiftUI
import InfiniteScrollModifier

public struct ExampleInfiniteScrollView: View {
    
    @State var data: [String] = []
    

    public init() {}
    
    public var body: some View {
        LazyVStack {
            Spacer(minLength: 20)
            Text("아래로 잡아당기기 ⬇️")
            ForEach(data, id: \.self) { item in
                Text(item)
            }
        }
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
            var arr: [String] = []
            try await Task.sleep(nanoseconds: 2_000_000_000)
            (1..<3).forEach { index in
                arr.append(UUID().uuidString)
            }
            data += arr
        } catch {
            
        }
    }
    
    func onRefresh() async {
        do {
            var arr: [String] = []
            try await Task.sleep(nanoseconds: 2_000_000_000)
            (0..<100).forEach { number in
                arr.append(UUID().uuidString)
            }
            data = arr
        } catch {
            
        }
    }
}
