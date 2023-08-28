//
//  PopupOptionButtonBannerView.swift
//  GeniePhone
//
//  Created by 이소정 on 2023/04/20.
//

import SwiftUI

// neverShowAgain,notShowForWeek,notShowToday type 의 popup button view 를 build.
internal struct PopupOptionButtonBannerView: View {
    let bannerId: String
    let closeType: BannerCloseType
    
    var body: some View {
        HStack {
            Button {
                BannerManager.instance
                    .dismissAndPresentPopup(id: bannerId,
                                            notShowedDate: closeType.notShowedDate)
            } label: {
                Text(closeType.title)
            }
            
            Spacer()
            
            Button {
                BannerManager.instance.dismissAndPresentPopup()
            } label: {
                Text("닫기")
            }
        }
    }
}

struct PopupOptionButtonBannerView_Previews: PreviewProvider {
    static var previews: some View {
        PopupOptionButtonBannerView(bannerId: "0000", closeType: .nerverShowAgain)
    }
}
