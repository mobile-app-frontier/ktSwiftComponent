//
//  PollingCenter.swift
//  ExamplePollingCenter
//
//  Created by 이소정 on 2023/08/24.
//

import Foundation
import PollingCenter

struct TestWorkItem: WorkItem {
    enum Category: WorkItemCategory {
        case callHistory
        case message
    }

    var category: Category
    var task: [PollingTask]
    var type: WorkItemType = .scheduled
}

final class TestPollingCenter {
    private init() {}
    
    static let instance = PollingCenter<TestWorkItem>()
}
