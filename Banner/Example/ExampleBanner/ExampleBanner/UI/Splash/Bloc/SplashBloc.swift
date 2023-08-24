//
//  SplashBloc.swift
//  ExampleBanner
//
//  Created by 이소정 on 2023/08/24.
//

import Foundation
import Banner

final class SplashBloc {
    @Published
    var state: SplashState = .fetching
    
    let bannerPolicyFetcher = BannerPolicyFetcher(dataSource: MockBannerPolicyDataSource(), localBannerPolicyGetter: <#T##() async -> LocalBannerPolicy#>, localBannerPolicySetter: <#T##(LocalBannerPolicy) async -> Void#>)
    
    func fetch() {
        guard case .fetching = state else {
            return
        }
        
        Task {
            
        }

    }
}
