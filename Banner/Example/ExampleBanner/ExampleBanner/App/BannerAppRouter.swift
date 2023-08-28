//
//  BannerAppRouter.swift
//  ExampleBanner
//
//  Created by 이소정 on 2023/08/24.
//

import UIKit
import NavRouter

final class BannerAppRouter: NavRouter {
    typealias Route = BannerAppRoute
    
    private let navigationController: UINavigationController
    private let startingRoute: Route?
    
    init(navigationController: UINavigationController = .init(), startingRoute: Route? = nil) {
        self.navigationController = navigationController
        self.startingRoute = startingRoute
    }
    
    func getNavigationController() -> UINavigationController {
        return navigationController
    }
    
    func getStartingRoute() -> BannerAppRoute? {
        return startingRoute
    }
}
