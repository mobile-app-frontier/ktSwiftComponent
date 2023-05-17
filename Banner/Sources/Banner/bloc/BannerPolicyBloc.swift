//
//  BannerPolicyBloc.swift
//  GeniePhone
//
//  Created by 이소정 on 2023/04/11.
//

import Foundation
import Kingfisher
import Utils

public typealias LocalBannerPolicy = [String : Int]

public final class BannerPolicyBloc: ObservableObject {
    /// `state`: BannerPolicyBloc 의 상태.
    @Published
    public var state: BannerPolicyState
    
    private let repository: BannerPolicyRepository
    
    /// `localBannerPolicyGetter`: 외부에서 injection 받은 단말에 저장되어 있는 LocalBannerPolicy 를 read 하는 function.
    private let localBannerPolicyGetter: () async -> LocalBannerPolicy
    /// `localBannerPolicySetter`: 외부에서 injection 받은 변경된 LocalBannerPolicy 를 단말에 write 하는 function.
    private let localBannerPolicySetter: (LocalBannerPolicy) async -> Void
    
    public init(state: BannerPolicyState = .initial,
                repository: BannerPolicyRepository,
                localBannerPolicyGetter: @escaping () async -> [String : Int],
                localBannerPolicySetter: @escaping ([String : Int]) async -> Void
    ) {
        self.state = state
        self.repository = repository
        self.localBannerPolicyGetter = localBannerPolicyGetter
        self.localBannerPolicySetter = localBannerPolicySetter
    }
    
    // remoteBannerPolicy 와 localBannerPolicy 를 동시에 fetch 함.
    public func fetch() async {
        // async let 구문을 이용하여 병렬로 비동기 함수 실행
        async let remoteBannerPolicy = repository.getBannerPolicy()
        async let localBannerPolicy = localBannerPolicyGetter()
        
        do {
            let bannerPolicy = try await (remote: remoteBannerPolicy,
                                          local: localBannerPolicy)
            state = .fetched(remoteBanner: bannerPolicy.remote,
                             localBanner: bannerPolicy.local)
            await handleBannerPolicy(remoteBanner: bannerPolicy.remote,
                                     localBanner: bannerPolicy.local)
        } catch {
            state = .fail(error)
            debugPrint("[BannerPolicy] fetch fail \(error)")
        }
    }
    
    // remote banner 와 local banner 를 비교하여 보여줄 배너를 filtering 하고, local banner 정책을 update, banner 가 image 타입이라면 해당 image 를 cache 함.
    private func handleBannerPolicy(
        remoteBanner: BannerPolicy,
        localBanner: LocalBannerPolicy
    ) async {
        let appVersion = Version.getAppVersion()
        
        // top banner filtering.
        let filteredDefaultBanner = filterValidRemoteBannerPolicy(
            defaultBanner: remoteBanner.defaultBanner,
            appVersion: appVersion)
        // bottom banner filtering.
        let filteredPopupBanner = filterValidBannerPolicy(
            remotePopupBanner: remoteBanner.popup,
            localBanner: localBanner,
            appVersion: appVersion)
        
        // local 정책 update
        await localBannerPolicySetter(filteredPopupBanner.localBanner)
        
        let imageUrls = filteredDefaultBanner.urls + filteredPopupBanner.urls
        
        // image cache
        cacheImage(urls: imageUrls)
        
        debugPrint("[BannerPolicy] fetch success")
        // state emit
        state = .success(
            willShowBanner: BannerPolicy(defaultBanner: filteredDefaultBanner.banner,
                                         popup: filteredPopupBanner.remoteBanner))
    }
    
    // 보여줄 remote default banner policy 를 filtering 함.
    // 또한, 각각의 category 에 따른 default banner policy 들을 sorting 함.
    // image 타입의 경우 미리 image cache 를 하기 위하여 image url List 를 만들어 return 함.
    private func filterValidRemoteBannerPolicy(defaultBanner: DefaultBannerPolicy,
                                               appVersion: Version
    ) -> (banner: DefaultBannerPolicy, urls: [URL]) {
        var filteredDefaultBanner = DefaultBannerPolicy()
        var urls: [URL] = []
        
        defaultBanner.keys.forEach { key in
            // target App Version 맞는 banner 만 필터링.
            filteredDefaultBanner[key] = defaultBanner[key]?
                .filter { state.equals(version: $0.targetAppversion, appVersion: appVersion) }
            
            // url 추가
            urls.append(contentsOf: filteredDefaultBanner[key]!
                .map { $0.content.url }
                .compactMap{ $0 })
            
            // sorting.
            filteredDefaultBanner[key] = filteredDefaultBanner[key]?.sorted(by: >)
        }
        return (filteredDefaultBanner, urls)
    }
    
    // 성능을 위하여 queue 를 한바퀴 돌면서 remote banner filtering / local banner update / image url filtering 을 같이 진행함.
    // 보여줄 remote popup banner policy 를 filtering 함.
    // 유효한 local banner 정책만 filtering 하여 update.
    // image 타입의 경우 미리 image cache 를 하기 위하여 image url List 를 만들어 return 함.
    private func filterValidBannerPolicy(remotePopupBanner: PopupBannerPolicy,
                                         localBanner: LocalBannerPolicy,
                                         appVersion: Version
    ) -> (remoteBanner: PopupBannerPolicy, localBanner: LocalBannerPolicy, urls: [URL]
    ) {
        var popupBannerPolicy = remotePopupBanner
        
        var filteredPopupBanner = PopupBannerPolicy()
        var updatedRemoteBanner: LocalBannerPolicy = [:]
        var urls: [URL] = []
        
        while (!popupBannerPolicy.isEmpty) {
            let popupBannerItem = popupBannerPolicy.pop()!
            
            // 서버에서 내려준 배너 정책에 대한 로컬 배너 정책이 저장되어 있다면 저장.
            updatedRemoteBanner[popupBannerItem.id] = localBanner[popupBannerItem.id]
            
            
            // app version 과 비교하여 보여줄 배너라면,
            if state.equals(version: popupBannerItem.targetAppversion, appVersion: appVersion) {
                // expired date 가 local 에 저장되지 않아있거나, 만료 기간이 지났다면,
                if state.isWillShow(notShowUntil: localBanner[popupBannerItem.id]) {
                    filteredPopupBanner.push(popupBannerItem)
                    
                    // 이미지 타입의 content 일경우, url 더함.
                    if case .image(let url) = popupBannerItem.content {
                        if let imageUrl = URL(string: url) {
                            urls.append(imageUrl)
                        }
                    }
                }
            }
        }
        
        return (filteredPopupBanner, updatedRemoteBanner, urls)
    }
    
    // image urls 을 cache.
    // https://www.avanderlee.com/swiftui/downloading-caching-images/
    // Kingfisher - https://github.com/onevcat/Kingfisher
    private func cacheImage(urls: [URL]) {
        let prefetcher = ImagePrefetcher(urls: urls)
        prefetcher.start()
        // 이미지 cache 를 기다리지는 않음.
    }
    
}
