//
//  AppRouter.swift
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


import NavRouter
import UIKit



final class AppRouter : NavRouter {
 
    
    typealias Route = AppRoute
    
    private let navigationController: UINavigationController
    private let startingRoute: Route?
    
    init(navigationController: UINavigationController = .init(), startingRoute: Route?) {
        self.navigationController = navigationController
        self.startingRoute = startingRoute
    }
    
    func getNavigationController() -> UINavigationController {
        return navigationController
    }
    
    func getStartingRoute() -> AppRoute? {
        return startingRoute
    }

    
    func didRouteNav(action: NavRouterAction) {
        
    }
}
