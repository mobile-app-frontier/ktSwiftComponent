//
//  DefualtIndexedScrollViewSectionPreview.swift
//  GeniePhone
//
//  Created by 이소정 on 2023/03/31.
//

import SwiftUI

internal extension IndexedScrollView {
    struct DefualtIndexedScrollViewSectionPreview: View where Key: StringProtocol{
        let key: Key
        
        let font: Font?
        let foregroundColor: Color?
        let backgroundColor: Color?
        
        var body: some View {
            Text(key)
                .font(font ?? .system(size: 18, weight: .semibold))
                .padding()
                .background(backgroundColor ?? Color(.systemGray6))
                .cornerRadius(5)
                .foregroundColor(foregroundColor)
        }
    }
}
