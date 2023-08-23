import SwiftUI
import PollingCenter

struct CallHistoryView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Call History Screen")
                
                Button {
                    // start Polling Service
                    TestPollingCenter.instance.start()
                } label: {
                    Text("Start Polling Center")
                }
                
                Button {
                    // stop Polling Service
                    TestPollingCenter.instance.stop()
                } label: {
                    Text("Stop Polling Center")
                }
                
                Button {
                    // change Polling inteval
                    TestPollingCenter.instance.interval = 3
                } label: {
                    Text("Change Polling Interval")
                }
                
                NavigationLink {
                    MessageView()
                } label: {
                    Text("Navigate to MessageView")
                }
            }
        }
        .onViewDidLoad {
            // start Polling Service
            TestPollingCenter.instance.start()
        }
        .onAppear {
            // add Work Item
            TestPollingCenter.instance
                .add(workItem: TestWorkItem(category: .callHistory,
                                            task: [
                                                { debugPrint("Call History: Task 1") },
                                                { debugPrint("Call History: Task 2") }
                                            ]))
        }
        .onDisappear {
            // remove Work Item by category
            TestPollingCenter.instance.remove(category: .callHistory)
        }
    }
}


