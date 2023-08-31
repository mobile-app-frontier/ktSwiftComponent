//
//  File.swift
//  
//
//  Created by pjx on 2023/03/31.
//

import SwiftUI


//MARK: - public navigation functions
public extension NavRouter {
    func start() {
        guard let route = getStartingRoute() else { return }
        
        didRouteNav(action: .start)
        push(route)
    }
    
    func present(_ route: Route, animated: Bool = false, isModal: Bool) {
        let viewController = UIHostingController(
            rootView: route.view()
                .environmentObject(self)
        )
        
        if isModal {
            viewController.modalPresentationStyle = .fullScreen
            getNavigationController().present(viewController, animated: animated)
            didRouteNav(action: .presentRouteModal(presentedRoute: route))
        } else {
            viewController.modalPresentationStyle = .formSheet
            getNavigationController().present(viewController, animated: animated)
            didRouteNav(action: .presentRouteSheet(presentedRoute: route))
        }
    }
    
    func present(_ route: Route, animated: Bool = true, options:NavRoutePresentOptions) {
        
        let viewController = UIHostingController(
            rootView: route.view()
                .environmentObject(self)
        )
        
        viewController.view.backgroundColor = options.backgroundColor
        viewController.modalTransitionStyle = options.modalTransitionStyle
        viewController.modalPresentationStyle = options.modalPresentationStyle
        
        getNavigationController().present(viewController, animated: animated)
        didRouteNav(action: .presentRouteSheet(presentedRoute: route))
    }
    
    
    
    func dismiss(animated: Bool = true) {
        getNavigationController().dismiss(animated: animated)
        
        didRouteNav(action: .dimissRoute)
    }
    
    
    func push(_ route: Route, animated: Bool = true, options:NavRoutePresentOptions? = nil) {
        
        let viewController = UIHostingController(
            rootView: route.view()
                .environmentObject(self)
                .navigationBarHidden(true)
        )
        
        viewController.restorationIdentifier = route.restorationIdentifier()
        if let options = options {
            viewController.view.backgroundColor = options.backgroundColor
            viewController.modalTransitionStyle = options.modalTransitionStyle
            viewController.modalPresentationStyle = options.modalPresentationStyle
        }
        
        getNavigationController().setToolbarHidden(true, animated: false)
        getNavigationController().setNavigationBarHidden(true, animated: false)
        
        getNavigationController().pushViewController(viewController, animated: animated)
        
        didRouteNav(action: .pushRoute(pushedRoute: route))
    }
    
    func pop(animated: Bool = true) {
        getNavigationController().popViewController(animated: animated)
        
        didRouteNav(action: .popRoute)
    }
    
    func popToRoot(animated: Bool = true) {
        getNavigationController().popToRootViewController(animated: animated)
        didRouteNav(action: .popToRoot)
    }
    
    func popToView(restorationIdentifier: String?, animated: Bool = true) {
        guard let restorationIdentifier = restorationIdentifier else {
            debugPrint("[Warning] restorationIdentifier is nil")
            return
        }
        
        guard let viewcontroller = getNavigationController().viewControllers.first(where: { viewcontroller in
            viewcontroller.restorationIdentifier == restorationIdentifier
        }) else {
            return
        }
        
        getNavigationController().popToViewController(viewcontroller, animated: animated)
        didRouteNav(action: .popToView(restorationIdentifier: restorationIdentifier))
    }
    
    
    func replace(_ route: Route, animated: Bool = true, options: NavRoutePresentOptions? = nil) {
        var viewControllers = getNavigationController().viewControllers
        /// remove last viewcontroller
        _ = viewControllers.popLast()
        
        let uiHostingController = UIHostingController(
            rootView: route.view()
                .environmentObject(self)
        )
        
        uiHostingController.navigationController?.setToolbarHidden(true, animated: false)
        
        uiHostingController.restorationIdentifier = route.restorationIdentifier()
        
        if let options = options {
            uiHostingController.view.backgroundColor = options.backgroundColor
            uiHostingController.modalTransitionStyle = options.modalTransitionStyle
            uiHostingController.modalPresentationStyle = options.modalPresentationStyle
        }
        
        viewControllers.append(uiHostingController)
        
        getNavigationController().setViewControllers(viewControllers, animated: animated)
        didRouteNav(action: .replaceRoute(replaced: route))
    }
    
    func replaceTo(_ route: Route, animated: Bool, restorationIdentifier: String, options:NavRoutePresentOptions? = nil) {
        var resultViewControllers = [UIViewController]()
        
        getNavigationController().viewControllers.forEach { viewController in
            resultViewControllers.append(viewController)
            if viewController.restorationIdentifier == restorationIdentifier {
                return
            }
        }
        
        // new Route ViewController
        let uiHostingController = UIHostingController(
            rootView: route.view()
                .environmentObject(self)
        )
        
        uiHostingController.navigationController?.setToolbarHidden(true, animated: false)
        
        uiHostingController.restorationIdentifier = route.restorationIdentifier()
        
        if let options = options {
            uiHostingController.view.backgroundColor = options.backgroundColor
            uiHostingController.modalTransitionStyle = options.modalTransitionStyle
            uiHostingController.modalPresentationStyle = options.modalPresentationStyle
        }
        
        resultViewControllers.append(uiHostingController)
        
        getNavigationController().setViewControllers(resultViewControllers, animated: animated)
        didRouteNav(action: .replaceRoute(replaced: route))
    }
    
    func didRouteNav(action: NavRouterAction) {
        // do nothing
    }
}
