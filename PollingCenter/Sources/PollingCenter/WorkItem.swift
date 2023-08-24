//
//  WorkItem.swift
//  GeniePhone
//
//  Created by 이소정 on 2023/04/05.
//

import Foundation

/// `PollingCenter` 에서 주기적으로 실행될 function.
public typealias PollingTask = () async -> Void

/// `PollingCenter` 에 `WorkItem` 을 추가 시 사용되는 실행 타입
///
/// - `immediate`: `WorkItem`이 추가되면 즉시 한 번 실행됨.
/// - `scheduled`: `WorkItem` 이 추가된 후, 다음 Polling 주기부터 실행됨.
public enum WorkItemType {
    case immediate
    case scheduled
}

/// `WorkItem` 들의 묶음 카테고리.
///
/// `PollingCenter` 에 등록된 WorkItem 들은 `WorkItemCategory` 에 따라 분류 될 수 있음.
public protocol WorkItemCategory: Hashable {}

/// Poling 을 실행할 Work 객체 Protocol.
/// ```
/// // Example
/// struct TestWorkItem: WorkItem {
///     enum Category: WorkItemCategory {
///         case callHistory
///         case message
///         ...
///     }
///
///     var category: Category
///     var task: [PollingTask]
///     var type: WorkItemType = .scheduled
/// }
///```
public protocol WorkItem {
    associatedtype Category: WorkItemCategory
    
    /// WorkItem 이 포함될 Category
    ///
    /// Polling 에서 사용되는 각각의 WorkItem 은 Category 를 가지고 있으며, Category 묶음으로 Task 를 삭제할 때 사용됨.
    var category: Category { get }
    
    /// `PollingTask` 그룹.
    ///
    /// `PollingCenter` 에 `WorkItem`를 추가하거나 삭제할 때 사용될 작업 그룹.
    var task: [PollingTask] { get }
    
    /// `PollingCenter` 에 `WorkItem` 이 추가될 때 사용되는 실행 종류
    var type: WorkItemType { get }
}
