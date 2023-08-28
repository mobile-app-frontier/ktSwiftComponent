//
//  PopupCloseOnlyButtonBannerView.swift
//  GeniePhone
//
//  Created by 이소정 on 2023/04/20.
//

import SwiftUI

// closeOnly 타입의 Button View. 닫기 버튼 하나만 존재.
internal struct PopupCloseOnlyButtonBannerView: View {
    let bannerId: String
    let closeType = BannerCloseType.closeOnly
    
    var body: some View {
        HStack {
            Spacer()
            
            Button {
                BannerManager.instance
                    .dismissAndPresentPopup(id: bannerId,
                                            notShowedDate: closeType.notShowedDate)
            } label: {
                Text("닫기")
                    .font(BannerManager.instance.popupButtonFont)
            }
        }
    }
}

struct PopupCloseOnlyButtonBannerView_Previews: PreviewProvider {
    static var previews: some View {
        PopupCloseOnlyButtonBannerView(bannerId: "0")
    }
}
