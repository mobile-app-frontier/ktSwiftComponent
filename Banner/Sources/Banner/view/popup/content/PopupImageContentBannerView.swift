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
    
    let leftSafeArea: CGFloat = UIApplication.shared.windows.first?.safeAreaInsets.left ?? 0
    let rightSafeArea: CGFloat = UIApplication.shared.windows.first?.safeAreaInsets.right ?? 0
    
    @Binding
    var height: CGFloat
    
    private var width: CGFloat {
        UIScreen.main.bounds.width - leftSafeArea - rightSafeArea
    }
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                KFImage.url(url)
                    .loadDiskFileSynchronously()
                    .onProgress { receivedSize, totalSize in
                        
                    }
                    .onSuccess { result in
                        let imageSize = result.image.size
                        height = width * imageSize.height / imageSize.width
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: width, height: height)
                    .ignoresSafeArea()
            }
        }
        
    }
}

struct PopupImageContentBannerView_Previews: PreviewProvider {
    static var previews: some View {
        PopupImageContentBannerView(url: URL(string: "https://fastly.picsum.photos/id/248/1000/400.jpg?hmac=SLxXRxNIg8fQ3R4yILJJ9eQpwBkdsWjnhMegYrgVIWM"),
                                    height: .constant(0))
    }
}
