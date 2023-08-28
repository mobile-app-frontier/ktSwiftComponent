//
//  PopupImageContentBannerView.swift
//  GeniePhone
//
//  Created by 이소정 on 2023/04/13.
//

import SwiftUI
import Kingfisher

// Image Type 의 popupBanner View.
internal struct PopupImageContentBannerView: View {
    let url: URL?
    
    @State
    var height: CGFloat = 0
    
    var body: some View {
        KFImage.url(url)
            .loadDiskFileSynchronously()
            .onProgress { receivedSize, totalSize in
                
            }
            .onSuccess { result in
                let imageSize = result.image.size
                let imageHeight = ViewSize.safeWidth * imageSize.height / imageSize.width
                
                if (imageHeight > ViewSize.safeHeight) {
                    height =  ViewSize.safeHeight
                }
                else {
                    height = imageHeight
                }
                
            }
            .resizable()
            .aspectRatio(contentMode: .fill)
//            .padding(.leading, leftSafeArea)
//            .padding(.trailing, rightSafeArea)
            .frame(height: height)
            .clipped()
            .ignoresSafeArea()
    }
}

struct PopupImageContentBannerView_Previews: PreviewProvider {
    static var previews: some View {
        PopupImageContentBannerView(url: URL(string:
//                                                "https://fastly.picsum.photos/id/248/1000/400.jpg?hmac=SLxXRxNIg8fQ3R4yILJJ9eQpwBkdsWjnhMegYrgVIWM"
                                     "https://fastly.picsum.photos/id/915/1000/800.jpg?hmac=_RM5t6845y3LrDALoiZBSRMfEo_Ig_Xf2x8Oavyiun8"
                                            ))
    }
}
