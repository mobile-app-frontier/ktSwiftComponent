//
//  DefaultTextDesign.swift
//  GeniePhone
//
//  Created by 이소정 on 2023/04/03.
//

import SwiftUI

/// `IndexedScrollView` 의 `IndexBar` or `SectionPreview` 의 TextDesign format.
public struct IndexedScrollViewTextDesign {
    /// 글자 font
    public let font: Font?
    /// 글자 색상
    public let foregroundColor: Color?
    /// 배경색
    public let backgroundColor: Color?
    
    public init(font: Font? = nil,
         foregroundColor: Color? = nil,
         backgroundColor: Color? = nil
    ) {
        self.font = font
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
    }
}
