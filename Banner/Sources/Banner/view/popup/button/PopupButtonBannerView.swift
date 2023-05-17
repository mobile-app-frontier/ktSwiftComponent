//
//  PopupButtonBannerView.swift
//  GeniePhone
//
//  Created by 이소정 on 2023/04/13.
//

import SwiftUI

// Popup Banner 의 Button View. closeType 에 따라 View 를 build.
internal struct PopupButtonBannerView: View {
    let bannerId: String
    let closeType: BannerCloseType
    
    var body: some View {
        switch closeType {
        case .closeOnly:
            PopupCloseOnlyButtonBannerView(bannerId: bannerId)
        case .nerverShowAgain:
            PopupOptionButtonBannerView(bannerId: bannerId,
                                        closeType: closeType)
        case .notShowForWeek:
            PopupOptionButtonBannerView(bannerId: bannerId,
                                        closeType: closeType)
        case .notShowToday:
            PopupOptionButtonBannerView(bannerId: bannerId,
                                        closeType: closeType)
        }
    }
}

struct PopupButtonBannerView_Previews: PreviewProvider {
    static var previews: some View {
        PopupButtonBannerView(bannerId: "1", closeType: .closeOnly)
    }
}
