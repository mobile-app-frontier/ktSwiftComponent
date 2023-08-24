//
//  BannerAppRoute.swift
//  ExampleBanner
//
//  Created by 이소정 on 2023/08/24.
//

import SwiftUI
import NavRouter
import Banner

enum BannerAppRoute: NavRoute {
    case splash
    case main
    case popupBanner(banner: PopupBannerPolicyItem)
}

extension BannerAppRoute {
    func restorationIdentifier() -> String? {
        switch self {
        case .splash:
            return "SplashScreen"
        case .main:
            return "MainScreen"
        case .popupBanner(_):
            return "PopupBannerView"
        }
    }
    
    @ViewBuilder
    func view() -> some View {
        switch self {
        case .splash:
            SplashScreen()
        case .main:
            MainScreen()
        case .popupBanner(let banner):
            PopupBannerView(banner: banner)
        }
    }
}
