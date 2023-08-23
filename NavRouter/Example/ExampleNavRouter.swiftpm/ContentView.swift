import SwiftUI


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
