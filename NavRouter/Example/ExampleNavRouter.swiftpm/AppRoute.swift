//
//  AppRoute.swift
//  ExampleNavRouter
//
//  Copyright (c) 2016 kt corp. All rights reserved.
//  This is a proprietary software of kt corp, and you may not use this file
//  except in compliance with license agreement with kt corp. Any redistribution
//  or use of this software, with or without modification shall be strictly
//  prohibited without prior written approval of kt corp, and the copyright
//  notice above does not evidence any actual or intended publication of such
//  software.
//
import SwiftUI
import NavRouter

enum AppRoute: NavRoute {
    case home
    case login
    case splash
    
    
}

//MARK: - AppRoute+NavRoute

extension AppRoute {
    func restorationIdentifier() -> String? {
        switch (self) {
        case .home:
            return "HOME"
        case .login:
            return "LOGIN"
        case .splash:
            return "SPLASH"
        }
    }
    
    
    @ViewBuilder
    func view() -> some View {
        switch (self) {
        case .home:
            HomeScreen()
        case .login:
            LoginScreen()
        case .splash:
            SplashScreen()
        }
    }
}
