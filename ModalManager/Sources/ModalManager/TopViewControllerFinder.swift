//
//  TopViewControllerFinder.swift
//  GeniePhone
//
//  Created by kimrlyunah on 2023/02/16.
//

import Foundation
import UIKit
import SwiftUI

func findTopViewController(
    baseVC: UIViewController? = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController
) -> UIViewController? {
    
    if let nav = baseVC as? UINavigationController {
        return findTopViewController(baseVC: nav.visibleViewController)
    }
    
    if let tab = baseVC as? UITabBarController {
        if let selected = tab.selectedViewController {
            return findTopViewController(baseVC: selected)
        }
    }
    
    if let presented = baseVC?.presentedViewController {
        return findTopViewController(baseVC: presented)
    }
    
    return baseVC
}
