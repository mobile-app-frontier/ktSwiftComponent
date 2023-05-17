//
//  IndexBarItemType.swift
//  GeniePhone
//
//  Created by 이소정 on 2023/04/03.
//

import SwiftUI

public extension IndexedScrollView where Key: StringProtocol{
    enum IndexBarItemType {
        case `default`(IndexedScrollViewTextDesign?)
        case custom((Key) -> any View)
        
        var content: ((Key) -> any View) {
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
        
        var design: IndexedScrollViewTextDesign? {
            switch self {
            case .default(let design):
                return design
            case .custom(_):
                return nil
            }
        }
    }
}
