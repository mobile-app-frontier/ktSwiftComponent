//
//  PopupContentBannerView.swift
//  GeniePhone
//
//  Created by 이소정 on 2023/04/12.
//

import SwiftUI

// Content Type 에 따라 View 를 build.
internal struct PopupContentBannerView: View {
    let type: PopupBannerPolicyItem.Content
    
    @Binding
    var height: CGFloat
    
    var body: some View {
        switch (type) {
        case .text(let content):
            PopupTextContentBannerView(content: content, height: $height)
        case .image(let url):
            PopupImageContentBannerView(url: URL(string: url), height: $height)
        case .html(let content):
            PopupHtmlContentBannerView(htmlString: content, height: $height)
        }
    }
}

struct PopupContentBannerView_Previews: PreviewProvider {
    static var previews: some View {
        PopupContentBannerView(
            type: .html("<h1>Hello, <strong>World!</strong></h1>"),
//            type: .text("test"),
//            type: .image(url:
//                                                "https://fastly.picsum.photos/id/248/1000/400.jpg?hmac=SLxXRxNIg8fQ3R4yILJJ9eQpwBkdsWjnhMegYrgVIWM"
//                                                "https://fastly.picsum.photos/id/565/1000/600.jpg?hmac=oJQa8_RLVzpyhJggqcyNnMUelPH8nqYUaqj65ws0p5c"
//                                           ),
                               height: .constant(0))
    }
}
