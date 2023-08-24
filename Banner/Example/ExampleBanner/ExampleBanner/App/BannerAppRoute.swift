//
//  BannerAppRoute.swift
//  ExampleBanner
//
//  Created by 이소정 on 2023/08/24.
//

import SwiftUI
import NavRouter

enum BannerAppRoute: NavRoute {
    case splash
    
    case main
}

extension BannerAppRoute {
    func restorationIdentifier() -> String? {
        switch self {
        case .splash:
            return "SplashScreen"
        case .main:
            return "MainScreen"
        }
    }
    
    @ViewBuilder
    func view() -> some View {
        switch self {
        case .splash:
            SplashScreen()
        case .main:
            MainScreen()
        }
    }
}
