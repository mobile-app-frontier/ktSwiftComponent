import XCTest
@testable import PollingCenter

final class PollingCenterTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        
        // Polling Service start.
        TestPollingCenter.instance.start()
        
        TestPollingCenter.instance.add(workItem: TestWorkItem(category: .callHistory,
                                                              task: [{
            debugPrint("Task")
        }]))
        // Polling Service stop.
        TestPollingCenter.instance.stop()
    }
}


// TO TEST
struct TestWorkItem: WorkItem {
    var category: Category
    
    var task: [PollingTask]
    var type: WorkItemType = .scheduled
    
    enum Category: WorkItemCategory {
        case callHistory
    }
}

final class TestPollingCenter {
    private init() {}
    
    static let instance = PollingCenter<TestWorkItem>()
}
