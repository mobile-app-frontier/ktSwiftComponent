//
//  SplashBloc.swift
//  ExampleBanner
//
//  Created by 이소정 on 2023/08/24.
//

import Foundation
import Banner
import Combine

final class SplashBloc {
    @Published
    var state: SplashState = .fetching
    
    let bannerPolicyFetcher = BannerPolicyFetcher(dataSource: MockBannerPolicyDataSource(),
                                                  localBannerPolicyGetter: { PreferenceDataStore.localBannerPolicy ?? [:] },
                                                  localBannerPolicySetter: { PreferenceDataStore.localBannerPolicy = $0 })
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        self.bannerPolicyFetcher.$state
            .receive(on: RunLoop.main)
            .sink { [weak self] bannerPolicyState in
                switch bannerPolicyState {
                case .success(_):
                    self?.state = .gotoMain
                case .fail(let error):
                    debugPrint(" banner policy fetch error \(error)")
                    self?.state = .gotoMain
                default:
                    break
                    
                }
            }
            .store(in: &subscriptions)
    }
    
    func fetch() {
        guard case .fetching = state else {
            return
        }
        
        Task {
            await bannerPolicyFetcher.fetch()
        }

    }
}
