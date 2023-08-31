//
//  SplashScreen.swift
//  ExampleBanner
//
//  Created by 이소정 on 2023/08/24.
//

import SwiftUI
import ModalManager

struct SplashScreen: View {
    @EnvironmentObject
    var navRouter: BannerAppRouter
    
    @State
    var splashBloc = SplashBloc()
    
    var body: some View {
        ProgressView()
            .onViewDidLoad {
                splashBloc.fetch()
            }
            .onReceive(splashBloc.$state) { state in
                switch state {
                case .gotoMain:
                    navRouter.replace(.main)
                case .exitApp:
                    ModalManager.getInstance().show {
                        VStack {
                            Text("네트워크 상태가 좋지 않습니다. 잠시 후 다시 앱을 실행해주세요.")
                            HStack {
                                Spacer()
                                Button {
                                    
                                } label: {
                                    Text("확인")
                                }
                            }
                        }
                    }
                default:
                    break
                }
            }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
