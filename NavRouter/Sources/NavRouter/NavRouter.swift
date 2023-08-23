
import SwiftUI

/// Navigation Action
/// navigation이 어떤 이벤트를 진행했는지 delegate로 전달하기 위한 model
///
public enum NavRouterAction{
    case start
    case pushRoute(pushedRoute: any NavRoute)
    case popRoute
    case popToRoot
    case popToView(restorationIdentifier: String)
    case presentRouteModal(presentedRoute: any NavRoute)
    case presentRouteSheet(presentedRoute: any NavRoute)
    case dimissRoute
    case replaceRoute(replaced: any NavRoute)
    case replaceRouteTo(replaced: any NavRoute)
}

/// NavRouter
/// SwiftUI 에서 UIKit의 ViewController 의 navigation방식을 사용 할 수 있도록
/// 돕는 interface
public protocol NavRouter: ObservableObject {
    associatedtype Route: NavRoute
    
    /// root navigation controller
    func getNavigationController() -> UINavigationController
    
    /// starting route
    /// start호출시 해당 route를 push한다.
    func getStartingRoute() -> Route?
    
    /// getStartingRoute()를push해주는 기능.
    func start()
    
    /// present modal or overlay screen
    func present(_ route: Route, animated: Bool , isModal: Bool)
    
    func present(_ route: Route, animated: Bool, options:NavRoutePresentOptions)
    
    /// dismiss present screen
    /// present로 올라온 view만 dismiss 가능
    /// push 된 view는 그대로 있는다.
    func dismiss(animated: Bool )
    
    /// navigation stack에 route를 추가
    func push(_ route: Route, animated: Bool, options:NavRoutePresentOptions?)
    
    /// navigation stack에서 최 상위 vc를 제거
    func pop(animated: Bool )
    
    /// navigation stack에 root로 이동 (사이에 있는 vc는 제거)
    func popToRoot(animated: Bool )
    
    /// navigation stack에 restorationIdentifier가 같은 vc로 이동 (사이에 있는 vc는 제거)
    /// 지정한 restorationIdentifier 가 vc에 없을시 아무 동작 안함.
    func popToView(restorationIdentifier: String?, animated: Bool)
    
    /// navigation stack에 최 상위vc를 제거 하고 신규 vc를 추가
    func replace(_ route: Route, animated: Bool, options:NavRoutePresentOptions?)
    
    /// navigation stack에 restorationIdentifier vc이후의 stack을 제거 하고 신규 vc를 추가
    func replaceTo(_ route: Route, animated: Bool, restorationIdentifier: String?, options:NavRoutePresentOptions?)
    
    /// NavRouter delegate
    func didRouteNav(action: NavRouterAction)
}
