//
//  SectionPreviewType.swift
//  GeniePhone
//
//  Created by 이소정 on 2023/03/31.
//

import SwiftUI

public extension IndexedScrollView where Key: StringProtocol{
    enum SectionPreviewType {
        case none
        case `default`(IndexedScrollViewTextDesign?)
        case custom((Key) -> any View)
        
        var content: ((Key) -> any View)? {
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
        
        var design: IndexedScrollViewTextDesign? {
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
