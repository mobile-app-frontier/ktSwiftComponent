//
//  ModalWindowStyle.swift
//  GeniePhone
//
//  Created by kimrlyunah on 2023/02/16.
//

import Foundation
import SwiftUI

public protocol ModalWindowStyle {
    var windowWidth: CGFloat { get }
    var windowHeight: CGFloat { get }
    var windowBackGround: Color { get }
    var windowForeGround: Color { get }
    var windowPadding: EdgeInsets { get }
    var windowCornerRadius: CGFloat { get }
    var windowShadow: CGFloat { get }
    var windowFont: Font { get }
}

public struct ResizableModalWindowStyle : ModalWindowStyle {
    public var windowWidth: CGFloat = 300
    public var windowHeight: CGFloat = 200
    public var windowBackGround: Color = .white
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
