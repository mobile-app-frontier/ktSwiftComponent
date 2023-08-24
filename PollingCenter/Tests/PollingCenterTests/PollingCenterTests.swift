import XCTest
@testable import PollingCenter

final class PollingCenterTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        
        let expectation = XCTestExpectation(description: "Polling Center test")
        
        // start Polling Service
        TestPollingCenter.instance.start()
        
        // change Polling interval
        TestPollingCenter.instance.interval = 1

        // add Work Item
        TestPollingCenter.instance.add(workItem: TestWorkItem(category: .callHistory,
                                                              task: [
                                                                { debugPrint("Task 1") },
                                                                { debugPrint("Task 2") }
                                                              ]))
        
        Task {
            try? await Task.sleep(nanoseconds: 10_000_000_000)
            expectation.fulfill()
        }
        
        // remove Work Item by category
        TestPollingCenter.instance.remove(category: .callHistory)

        // remove all Work Items
        TestPollingCenter.instance.removeAll()

        // stop Polling Service
        TestPollingCenter.instance.stop()
        
        wait(for: [expectation], timeout: 10.0)
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
