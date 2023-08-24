//
//  MessageView.swift
//  ExamplePollingCenter
//
//  Created by 이소정 on 2023/08/24.
//

import SwiftUI

struct MessageView: View {
    var body: some View {
        VStack {
            Text("Message View")
        }.onAppear {
            // add Work Item
            TestPollingCenter.instance
                .add(workItem: TestWorkItem(category: .message,
                                            task: [
                                                { debugPrint("Message: Task 1") },
                                                { debugPrint("Message: Task 2") }
                                            ]))
        }
        .onDisappear {
            // remove Work Item by category
            TestPollingCenter.instance.remove(category: .message)
        }
        
    }
        
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}
