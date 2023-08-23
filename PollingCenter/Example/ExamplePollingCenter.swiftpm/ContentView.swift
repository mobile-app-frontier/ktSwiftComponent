import SwiftUI
import PollingCenter

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .onAppear {
            // start Polling Service
            TestPollingCenter.instance.start()
            
            // change Polling interval
            TestPollingCenter.instance.interval = 3

            // add Work Item
            TestPollingCenter.instance.add(workItem: TestWorkItem(category: .callHistory,
                                                                  task: [
                                                                    { debugPrint("Task 1") },
                                                                    { debugPrint("Task 2") }
                                                                  ]))
            
            Task {
                try? await Task.sleep(nanoseconds: 10_000_000_000)
                
                // remove Work Item by category
                TestPollingCenter.instance.remove(category: .callHistory)

                // remove all Work Items
                TestPollingCenter.instance.removeAll()

                // stop Polling Service
                TestPollingCenter.instance.stop()
            }
        }
    }
}

struct TestWorkItem: WorkItem {
    enum Category: WorkItemCategory {
        case callHistory
        case message
    }

    var category: Category
    var task: [PollingTask]
    var type: WorkItemType = .immediate
}

final class TestPollingCenter {
    private init() {}
    
    static let instance = PollingCenter<TestWorkItem>()
}
