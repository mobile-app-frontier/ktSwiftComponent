//
//  File.swift
//  
//
//  Created by pjx on 2023/03/27.
//

import SwiftUI

public protocol NavRoute {
    
    associatedtype Destination: View
    
    /// view ID로 mapping
    /// popToView에서 사용함.
    func restorationIdentifier() -> String?
    
    /// Creates and returns a view of assosiated type
    ///
    @ViewBuilder
    func view() -> Destination
}


extension NavRoute {
    func restorationIdentifier() -> String? {
        return nil
    }
}
