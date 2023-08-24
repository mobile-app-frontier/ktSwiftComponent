//
//  MainScreen.swift
//  ExampleBanner
//
//  Created by 이소정 on 2023/08/24.
//

import SwiftUI
import Banner
import NavRouter

struct MainScreen: View {
    @EnvironmentObject
    var navRouter: BannerAppRouter
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Main Screen")
            
            BannerManager.instance.buildDefaultBannerView(category: "callHistory")
            
            Spacer()
        }
        .padding(10)
        .onViewDidLoad {
            // start popup banner
            BannerManager.instance.start(present: { popupBanner in
                navRouter.presentWithOptions(.popupBanner(banner: popupBanner),
                                             options: NavRoutePresentOptions())
            },
            dismiss: { navRouter.dismiss(animated: false) })
        }
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
