//
//  PopupTextContentBannerView.swift
//  GeniePhone
//
//  Created by 이소정 on 2023/04/13.
//

import SwiftUI

// Text Type 의 popupBanner View.
internal struct PopupTextContentBannerView: View {
    let content: String
    
    @Binding
    var height: CGFloat
    
    var body: some View {
        Text(content)
            .padding([.leading, .trailing, .top], 10)
            .background(GeometryReader {
                Color.clear.preference(
                    key: TextSizeKey.self,
                    value: $0.frame(in: .local).size
                )
            })
            .onPreferenceChange(TextSizeKey.self) {
                height = $0.height + 20
            }
    }
    
    private struct TextSizeKey: PreferenceKey {
        static var defaultValue: CGSize = .zero

        static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
            value = nextValue()
        }
    }
}

struct PopupTextContentBannerView_Previews: PreviewProvider {
    static var previews: some View {
        PopupTextContentBannerView(content: "test", height: .constant(0))
    }
}
