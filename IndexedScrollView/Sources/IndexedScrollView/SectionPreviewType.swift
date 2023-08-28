//
//  SectionPreviewType.swift
//  GeniePhone
//
//  Created by 이소정 on 2023/03/31.
//

import SwiftUI

public extension IndexedScrollView where Key: StringProtocol{
    /// `SectionPreview` View 의 종류.
    ///
    /// `SectionPreview` 를 없애거나 기본 제공 UI 에서 TextDesign 을 변경할 때, custom View 를 올리고 싶을 때 사용.
    ///
    /// - `none`: `SectionPreview` 를 사용하고 싶지 않을 때
    /// - `default`: `IndexedScrollView` 내부에서 기본적으로 제공하는 View 를 사용.
    /// Parameter 로 `IndexedScrollViewTextDesign` 를 넣어 Text Style 을 지정할 수 있음.
    /// - `custom`: Parameter 로 넣어준 ViewBuilder 를 사용하여 `SectionPreview` View 를 customize 할 수 있음.
    enum SectionPreviewType {
        case none
        case `default`(IndexedScrollViewTextDesign?)
        case custom((Key) -> any View)
        
        internal var content: ((Key) -> any View)? {
            switch self {
            case .none:
                return nil
            case .default(let design):
                return { key in
                    DefualtIndexedScrollViewSectionPreview(key: key,
                                                           font: design?.font,
                                                           foregroundColor: design?.foregroundColor,
                                                           backgroundColor: design?.backgroundColor
                    )
                }
            case .custom(let content):
                return content
            }
        }
        
        internal var design: IndexedScrollViewTextDesign? {
            switch self {
            case .none:
                return nil
            case .default(let design):
                return design
            case .custom(_):
                return nil
            }
        }
    }
}
