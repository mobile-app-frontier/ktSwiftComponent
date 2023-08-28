//
//  File.swift
//  
//
//  Created by 이소정 on 2023/08/28.
//

import Foundation
import UIKit

class ViewSize {
    static private let topSafeArea: CGFloat = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
    static private let bottomSafeArea: CGFloat = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
    static private let leftSafeArea: CGFloat = UIApplication.shared.windows.first?.safeAreaInsets.left ?? 0
    static private let rightSafeArea: CGFloat = UIApplication.shared.windows.first?.safeAreaInsets.right ?? 0
    
    static internal var safeWidth: CGFloat {
        UIScreen.main.bounds.width - leftSafeArea - rightSafeArea
    }
    
    static internal var safeHeight: CGFloat {
        UIScreen.main.bounds.height - bottomSafeArea - topSafeArea - 100
    }
}
