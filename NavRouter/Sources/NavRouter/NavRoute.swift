//
//  File.swift
//  
//
//  Created by pjx on 2023/03/27.
//

import SwiftUI
import UIKit

public protocol NavRoute {
    
    associatedtype Destination: View
    
    /// view ID로 mapping
    /// popToView에서 사용함.
    func restorationIdentifier() -> String?
    
    /// navigation option setting
    /// ``` Swift
    /// struct SomeRoute: NavRoute {
    ///     ...
    ///     func applyNavigationOptions(controller: UINavigationController) {
    ///        controller.isNavigationBarHidden = true
    ///     }
    ///     ...
    /// }
    /// ```
    func applyNavigationOptions(controller: UINavigationController?)
    
    /// Creates and returns a view of assosiated type
    ///
    @ViewBuilder
    func view() -> Destination
    
    var statusBarStyle: UIStatusBarStyle { get }
}


extension NavRoute {
    func restorationIdentifier() -> String? {
        return nil
    }
    
    func applyNavigationOptions(controller: UINavigationController?){
        
    }
}
