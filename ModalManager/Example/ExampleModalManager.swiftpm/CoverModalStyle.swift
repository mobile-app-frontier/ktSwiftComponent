//
//  CoverModalStyle.swift
//  ExampleModalManager
//
//  Created by kimrlyunah on 2023/08/28.
//

import Foundation
import ModalManager
import UIKit
import SwiftUI

public struct CoverModalStyle: ModalStyle {
    public let modalPresentationStyle: UIModalPresentationStyle
    public let modalBackground: UIColor
    public let modalTransitionStyle: UIModalTransitionStyle
    
    init(
        modalPresentationStyle: UIModalPresentationStyle = .automatic,
        modalBackground: UIColor = UIColor.black.withAlphaComponent(0.2),
         modalTransitionStyle: UIModalTransitionStyle = .coverVertical
    ) {
        self.modalPresentationStyle = modalPresentationStyle
        self.modalBackground = modalBackground
        self.modalTransitionStyle = modalTransitionStyle
    }
}

public struct CoverModalWindowStyle: ModalWindowStyle {
    
    public var windowWidth: CGFloat = UIScreen.main.bounds.width
    public var windowHeight: CGFloat = UIScreen.main.bounds.height
    public var windowBackGround: Color = .green.opacity(50)
    public var windowForeGround: Color = .black
    public var windowPadding: EdgeInsets = EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
    public var windowCornerRadius: CGFloat = 10
    public var windowShadow: CGFloat = 5
    public var windowFont: Font = .system(size: 14)
    
    public init() {}
    
    public init(
        windowWidth: CGFloat,
        windowHeight: CGFloat,
        windowBackGround: Color,
        windowForeGround: Color,
        windowPadding: EdgeInsets
    ) {
        self.windowWidth = windowWidth
        self.windowHeight = windowHeight
        self.windowBackGround = windowBackGround
        self.windowForeGround = windowForeGround
        self.windowPadding = windowPadding
    }
}
