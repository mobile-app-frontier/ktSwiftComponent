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
    
    var body: some View {
        HStack {
            Text(content)
                .font(BannerManager.instance.popupTextContentFont)
                .foregroundColor(BannerManager.instance.popupTextContentColor)
                .padding([.leading, .trailing, .top], 10)
            Spacer()
        }
        
    }
}

struct PopupTextContentBannerView_Previews: PreviewProvider {
    static var previews: some View {
        PopupTextContentBannerView(content: "test")
    }
}
