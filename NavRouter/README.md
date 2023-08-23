# NavRouter

Module description

- [Example](#example)
- [Functions](#funcitons)
- [API Document](#api-document)

## Example

### Step1. Route 정의

``` Swift

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

```

### Step2. define Router

``` Swift

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

}

```


### Step1. define app delegate

- UIApplicationDelegate 정의
``` Swift
import UIKit

@main
final class AppDelegate : NSObject,UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        return true
    }
    
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        let sessionRole = connectingSceneSession.role
        let sceneConfig = UISceneConfiguration(name: nil, sessionRole: sessionRole)
        sceneConfig.delegateClass = AppSceneDelegate.self
        return sceneConfig
    }
}

```

- UIWindowSceneDelegate 정의

``` Swift

final class AppSceneDelegate: NSObject, UIWindowSceneDelegate {
        
    /// define first route screen
    private let router: GenieRouter = .init(startingRoute: .splash(true))
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = router.getNavigationController()
        window?.makeKeyAndVisible()

        // Start를 해줘야 최초 정의한 Route로 Routing한다.
        router.start()
    }
}

```

> **NOTE:** \
> func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) 에서 \
> **router.start()** 를 안하면  정상적으로 동작 안함. 


### Step3. define screen

``` Swift

//MARK: - Screen Contents

struct HomeScreen: View {
    @EnvironmentObject
    var router: AppRouter
    
    var body: some View {
        VStack {
            Color.red
            
            Button {
                /// pop to root
                router.popToRoot()
                
                /// pop by view id
//                router.popToView(restorationIdentifier: AppRoute.splash.restorationIdentifier())
            } label: {
                Text("pop to Splash")
            }
        }
    }
}


struct LoginScreen: View {
    @EnvironmentObject
    var router: AppRouter
    
    var body: some View {
        HStack {
            Color.green
            Button {
                router.replace(.home)
            } label: {
                Text("replace Home")
            }
        }
    }
}


struct SplashScreen: View {
    @EnvironmentObject
    var router: AppRouter
    
    var body: some View {
        VStack {
            Color.blue
            Button {
                router.push(.login)
            } label: {
                Text("go Login")
            }
        }
    }
}

```

## Functions 

### [Push](/Documentation/NavRouter/NavRouter.md)
: ViewController Stack에 신규 ViewController를 추가 

### [Present](/Documentation/NavRouter/NavRouter.md)
: 현재 화면에 신규 ViewController를 modal형태로 올리는 방식으로 \
BottomSheet, ViewController가 올라 갈 수 있다.

### [pop](/Documentation/NavRouter/NavRouter.md)
Push를 통해 추가 된 ViewController를 Stack에서 제거 할때 사용한다.

### [dismiss](/Documentation/NavRouter/NavRouter.md)
present를 통해 노출되는 화면을 화면 에서 지우고 싶을때 사용한다.

### [didRouteNav](/Documentation/NavRouter/NavRouter.md)
NavRouter에서 Navigation이 발생할때 callback을 주는 function으로 \
주로 analytics등을 위한 목적으로 사용한다.



----------

## [API Document](/Documentation/NavRouter/Home.md)

