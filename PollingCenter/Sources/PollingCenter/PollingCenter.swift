//
//  PollingCenter.swift
//  GeniePhone
//
//  Created by 이소정 on 2023/04/05.
//

import Foundation

public final class PollingCenter<Item: WorkItem> {

    private var workItems: [Item] = []
    private var timer: Timer? = nil
    
    
    public var interval = 1.0 {
        didSet {
            stop()
            start()
        }
    }
    
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
    
    public func stop() {
        debugPrint("[PollingCenter] stop")
        
        timer?.invalidate()
        timer = nil
    }
    
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
    
    public func remove(category: Item.Category) {
        debugPrint("[PollingCenter] remove category \(category)")
        workItems.removeAll { item in
            item.category == category
        }
    }
    
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
