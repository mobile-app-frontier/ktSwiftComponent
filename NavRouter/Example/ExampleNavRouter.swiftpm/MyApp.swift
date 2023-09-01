import SwiftUI
import NavRouter
import UIKit


@main
struct TestSSApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                SplashScreen()
            }
            
        }
    }
}


//@main
//final class AppDelegate : NSObject,UIApplicationDelegate {
//    func application(
//        _ application: UIApplication,
//        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
//    ) -> Bool {
//        return true
//    }
//    
//    func application(
//        _ application: UIApplication,
//        configurationForConnecting connectingSceneSession: UISceneSession,
//        options: UIScene.ConnectionOptions
//    ) -> UISceneConfiguration {
//        let sessionRole = connectingSceneSession.role
//        let sceneConfig = UISceneConfiguration(name: nil, sessionRole: sessionRole)
//        sceneConfig.delegateClass = AppSceneDelegate.self
//        return sceneConfig
//    }
//}
//
//// define scene delegate
//final class AppSceneDelegate: NSObject, UIWindowSceneDelegate {
//        
//    /// define first route screen
//    private let router: AppRouter = .init(startingRoute: .splash)
//    
//    var window: UIWindow?
//
//    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        guard let windowScene = (scene as? UIWindowScene) else { return }
//        window = UIWindow(windowScene: windowScene)
//        window?.rootViewController = router.getNavigationController()
//        window?.makeKeyAndVisible()
//        router.getNavigationController().isNavigationBarHidden = true
//        router.start()
//    }
//}
