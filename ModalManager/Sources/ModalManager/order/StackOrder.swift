//
//  SequentialOrder.swift
//  GeniePhone
//
//  Created by kimrlyunah on 2023/02/16.
//

import Foundation
import SwiftUI
import Combine

public class StackOrder: ModalOrder {
    
    private var modalReferenceArray: [ModalController] = []
    
    public func add(
        controller: ModalController
    ) {
        modalReferenceArray.append(controller)
    }
    
    public func remove() {
        modalReferenceArray.removeLast()
    }
    
    public func topModal() -> ModalController? {
        return modalReferenceArray.last ?? nil
    }
    
    public func modals() -> Int {
        return modalReferenceArray.count
    }
    
}
