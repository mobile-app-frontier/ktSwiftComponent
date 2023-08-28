//
//  PopupContentBannerView.swift
//  GeniePhone
//
//  Created by 이소정 on 2023/04/12.
//

import SwiftUI

// Content Type 에 따라 View 를 build.
internal struct PopupContentBannerView: View {
    let banner: PopupBannerPolicyItem
    
    var body: some View {
        VStack(spacing: 10) {
            /// content
            switch (banner.content) {
            case .text(let content):
                PopupTextContentBannerView(content: content)
            case .image(let url):
                PopupImageContentBannerView(url: URL(string: url))
            case .html(let content):
                PopupHtmlContentBannerView(htmlString: content,
                                           id: banner.id,
                                           closeType: banner.closeType
                )
            }
            
            if case .html = banner.content {}
            else {
                /// button
                PopupButtonBannerView(bannerId: banner.id,
                                      closeType: banner.closeType)
                    .buttonStyle(.plain)
            }
            
            
        }
    }
}

struct PopupContentBannerView_Previews: PreviewProvider {
    static var previews: some View {
        PopupContentBannerView(banner: PopupBannerPolicyItem(id: "1",
                                                             priority: 1,
                                                             targetAppversion: nil,
                                                             landingType: .none,
                                                             content:
                       .html("<h1>Hello, <strong>World!</strong></h1>"),
       //                .text("blablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablabla"),
       //                .image(url: "https://fastly.picsum.photos/id/565/1000/600.jpg?hmac=oJQa8_RLVzpyhJggqcyNnMUelPH8nqYUaqj65ws0p5c"),
                                                             closeType: .closeOnly)
                               )
    }
}
