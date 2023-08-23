//
//  PollingCenter.swift
//  GeniePhone
//
//  Created by 이소정 on 2023/04/05.
//

import Foundation

/// 일정 시간 간격으로 어떠한 작업들을 동시에 실행할 수 있음.
///
///  `WorkItem` Protocol 을 따르는 Item 단위로 Polling Scheduler 에 작업들을 추가하거나 삭제할 수 있음.
public final class PollingCenter<Item: WorkItem> {
    public init() {}

    /// 주기적으로 실행될 작업들의 모음.
    private var workItems: [Item] = []
    /// 주기적으로 어떤 작업을 실행하기 위한 Timer.
    private var timer: Timer? = nil
    
    /// `PollingCenter` 가 주기적으로 실행되는 시간 간격(second). default 는 1 second.
    ///
    /// - Important: `interval` 를 변경할 경우 기존의 Polling 주기가 취소되고 새로운 주기로 `WorkItem`
    /// 들이 다시 실행됨. 즉, `interval` 이 수정된 즉시 등록되어 있는 `WorkItem`들이 실행될 수 있음.
    ///
    public var interval = 1.0 {
        didSet {
            stop()
            start()
        }
    }
    
    /// `PollingCenter` 에 등록된 `WorkItem` 들이 주기적으로 실행되기 시작함.
    ///
    /// 초기에 한번 혹은 stop() 호출 뒤에 사용할 것을 권장. 이미 `PollingCenter` 가 start 되어 있다면, 아무런 동작을 하지 않음.
    public func start() {
        guard timer == nil else {
            return
        }
        debugPrint("[PollingCenter] start")
        timer = Timer.scheduledTimer(withTimeInterval: interval,
                                     repeats: true,
                                     block: { [unowned self] timer in
            Task {
                await run()
            }
        })
    }
    
    /// `PolingCenter` 의 주기적인 작업 호출들을 멈춤.
    ///
    /// 해당 function 을 호출 할 경우, 주기적인 작업 호출은 멈추나 등록되어 있는 `WorkItem`들이 사라지지는 않음. 등록되어 있는 `WorkItem` 들을 지우고 싶다면 `remove(category:) or removeAll()` 을 사용할 것.
    public func stop() {
        debugPrint("[PollingCenter] stop")
        
        timer?.invalidate()
        timer = nil
    }
    
    /// `PollingCenter`에 `WorkItem` 을 추가함.
    ///
    /// - Important: 같은 Category 의 `WorkItem` 을 여러개 추가할 수 없음.
    /// 이미 등록되어 있는 Category 의 `WorkItem` 을 추가할 경우, 기존에 있는 `WorkItem`
    /// 은 삭제되고 새로 추가됨.
    ///
    /// - Parameter workItem:`PollingCenter` 에 등록하여 주기적으로 실행할 작업.
    public func add(workItem: Item) {
        debugPrint("[PollingCenter] add workItem \(workItem.category)")
        // 이미 등록되어 있는 category 일 경우, 지우고 다시 등록.
        remove(category: workItem.category)
        
        workItems.append(workItem)
        
        if case .immediate = workItem.type {
            Task {
                await run(workItem: workItem)
            }
        }
    }
    
    /// `PollingCenter` 에서 `category` 에 해당하는 `WorkItem` 을 삭제함.
    ///
    /// - Parameter category: 삭제할 `WorkItem`의 카테고리
    public func remove(category: Item.Category) {
        debugPrint("[PollingCenter] remove category \(category)")
        workItems.removeAll { item in
            item.category == category
        }
    }
    
    /// `PollingCenter` 에 등록되어 있는 모든 `WorkItem` 들을 지움.
    ///
    /// 해당 function 을 호출할 경우 내부에서 `stop()`이 호출됨.
    public func removeAll() {
        debugPrint("[PollingCenter] remove all workItem")
        stop()
        workItems = []
    }
    
    private func run() async {
        await withTaskGroup(of: Void.self) { group in
            for workItem in workItems {
                group.addTask { [unowned self] in
                    await run(workItem: workItem)
                }
            }
        }
    }
    
    private func run(workItem: Item) async {
        await withTaskGroup(of: Void.self) { group in
            for task in workItem.task {
                group.addTask {
                    await task()
                }
            }
        }
    }
}
