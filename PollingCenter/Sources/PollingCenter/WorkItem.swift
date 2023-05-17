//
//  WorkItem.swift
//  GeniePhone
//
//  Created by 이소정 on 2023/04/05.
//

import Foundation

public typealias PollingTask = () async -> Void

public enum WorkItemType {
    case immediate
    case scheduled
}

public protocol WorkItemCategory: Hashable, Equatable {}

public protocol WorkItem {
    associatedtype Category: WorkItemCategory
    
    var category: Category { get }
    var task: [PollingTask] { get }
    var type: WorkItemType { get }
}
