//
//  ModalOrderOptions.swift
//  GeniePhone
//
//  Created by kimrlyunah on 2023/02/16.
//

import Foundation

/// TODO
public struct ModalOrderOptions {
    var priority: ModalOrderPriority?
    var removeControllersOnAdd: Bool?
    
    init(priority: ModalOrderPriority? = nil, removeControllersOnAdd: Bool? = nil) {
        self.priority = priority
        self.removeControllersOnAdd = removeControllersOnAdd
    }
}

public enum ModalOrderPriority {
    case high
    case low
}
