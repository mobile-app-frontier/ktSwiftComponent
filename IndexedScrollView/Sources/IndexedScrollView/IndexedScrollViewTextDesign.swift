//
//  DefaultTextDesign.swift
//  GeniePhone
//
//  Created by 이소정 on 2023/04/03.
//

import SwiftUI

public struct IndexedScrollViewTextDesign {
    let font: Font?
    let foregroundColor: Color?
    let backgroundColor: Color?
    
    init(font: Font? = nil, foregroundColor: Color? = nil, backgroundColor: Color?) {
        self.font = font
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
    }
}
