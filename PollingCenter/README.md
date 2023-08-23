# PollingCenter

주기적으로 어떠한 작업들을 병렬로 실행할 수 있는 기능을 제공 한다.

- [Example](#example)
- [structure](#structure)
- [MORE](#more)

## Example

``` Swift
// Code block
struct TestWorkItem: WorkItem {
    enum Category: WorkItemCategory {
        case callHistory
        case message
        ...
    }

    var category: Category
    var task: [PollingTask]
    var type: WorkItemType = .scheduled
}

let pollingCenter = PollingCenter<TestWorkItem>()

// start Polling Service
pollingCenter.start()

// add Work Item
pollingCenter.add(workItem: TestWorkItem(category: .callHistory,
                                         task: [ 
                                            { debugPrint("Task 1")},
                                            { debugPrint("Task 2")}
                                         ]))

// remove Work Item by category
pollingCenter.remove(category: .callHistory)

// remove all Work Items
pollingCenter.removeAll()

// stop Polling Service
pollingCenter.stop()

```

## Structure
- PollingCenter
- WorkItem

## [MORE](/Documentation/PollingCenter/Home.md)
