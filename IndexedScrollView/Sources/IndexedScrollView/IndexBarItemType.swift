//
//  IndexBarItemType.swift
//  GeniePhone
//
//  Created by 이소정 on 2023/04/03.
//

import SwiftUI

public extension IndexedScrollView where Key: StringProtocol {
    /// `IndexBar` View 의 종류.
    ///
    /// `IndexBar` 의 TextDesign 을 변경하거나, custom View 를 올리고 싶을 때 사용.
    ///
    /// - `default`: `IndexedScrollView` 내부에서 기본적으로 제공하는 View 를 사용.
    /// Parameter 로 `IndexedScrollViewTextDesign` 를 넣어 Text Style 을 지정할 수 있음.
    /// - `custom`: Parameter 로 넣어준 ViewBuilder 를 사용하여 `IndexBar` View 를 customize 할 수 있음.
    enum IndexBarItemType {
        case `default`(IndexedScrollViewTextDesign?)
        case custom((Key) -> any View)
        
        internal var content: ((Key) -> any View) {
            switch self {
            case .default(let design):
                return { key in
                    DefaultIndexedScrollViewBarItem(key: key,
                                                    font: design?.font,
                                                    foregroundColor: design?.foregroundColor
                    )
                }
            case .custom(let content):
                return content
            }
        }
        
        internal var design: IndexedScrollViewTextDesign? {
            switch self {
            case .default(let design):
                return design
            case .custom(_):
                return nil
            }
        }
    }
}
