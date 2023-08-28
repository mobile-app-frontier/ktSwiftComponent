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
    
    private let bottomSafeArea: CGFloat = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
    private let leftSafeArea: CGFloat = UIApplication.shared.windows.first?.safeAreaInsets.left ?? 0
    private let rightSafeArea: CGFloat = UIApplication.shared.windows.first?.safeAreaInsets.right ?? 0
    
    var body: some View {
        ZStack {
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
        .padding(.bottom, bottomSafeArea == 0 ? 10 : bottomSafeArea)
        .padding(.leading, leftSafeArea == 0 ? 10 : leftSafeArea)
        .padding(.trailing, rightSafeArea == 0 ? 10 : rightSafeArea)
    }
}

struct PopupButtonBannerView_Previews: PreviewProvider {
    static var previews: some View {
        PopupButtonBannerView(bannerId: "1", closeType: .closeOnly)
    }
}
