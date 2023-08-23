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
    let font: Font?
    /// 글자 색상
    let foregroundColor: Color?
    /// 배경색
    let backgroundColor: Color?
    
    init(font: Font? = nil, 
         foregroundColor: Color? = nil,
         backgroundColor: Color?
    ) {
        self.font = font
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
    }
}
