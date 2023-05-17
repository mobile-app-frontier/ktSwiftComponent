//
//  DefaultIndexedScrollViewBarItem.swift
//  GeniePhone
//
//  Created by 이소정 on 2023/03/31.
//

import SwiftUI

internal extension IndexedScrollView {
    struct DefaultIndexedScrollViewBarItem: View where Key: StringProtocol{
        let key: Key
        
        let font: Font?
        let foregroundColor: Color?
        
        var body: some View {
            Text(key)
                .font(font ?? .system(size: 10))
                .foregroundColor(foregroundColor)
        }
    }
}
