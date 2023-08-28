//
//  BannerPolicy.swift
//  GeniePhone
//
//  Created by 이소정 on 2023/04/10.
//

import Foundation

/// 배너 정책
public struct BannerPolicy {
    /// defaultBanner. `[Category:[DefaultBannerPolicyItem]].` 
    ///
    /// category 별로 `DefaultBannerPolicyItem` 을 가지고 있음.
    /// - Important: `DefaultBanner` 는 `BannerPolicyFetcher` 내부에서 정렬을 수행하므로,  `priority` 에 따라서 정렬되지 않아 있을 수 있음.
    internal let defaultBanner: DefaultBannerPolicy
    
    /// PopupBanner. `PriorityQueue<PopupBannerPolicyItem>`.
    ///
    /// priority 가 높은 순부터 정렬되어 있음.
    internal let popup: PopupBannerPolicy
    
    internal init(defaultBanner: DefaultBannerPolicy, popup: PopupBannerPolicy) {
        self.defaultBanner = defaultBanner
        self.popup = popup
    }
    
    internal init(from model: [BannerPolicyItemModel]) {
        // TODO: 이렇게 하면 두바퀴를 돔. 성능에 문제가 있을시 수정 필요.
        self.defaultBanner = DefaultBannerPolicy(from: model)
        self.popup = PopupBannerPolicy(from: model)
    }
}
