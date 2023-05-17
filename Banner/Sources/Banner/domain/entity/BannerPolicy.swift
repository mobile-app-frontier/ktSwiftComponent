//
//  BannerPolicy.swift
//  GeniePhone
//
//  Created by 이소정 on 2023/04/10.
//

import Foundation

public struct BannerPolicy {
    /// `defaultBanner`: defaultBanner. Category:[DefaultBannerPolicyItem]. category 별로 DefaultBannerPolicyItem 을 가지고 있음. DefaultBanner 는 Bloc 에서 banner filtering 시에 정렬이 되므로, 현재 정렬되어 있지 않음.
    let defaultBanner: DefaultBannerPolicy
    /// `popup`: PopupBanner. PriorityQueue<PopupBannerPolicyItem>. priority 가 높은 순부터 정렬되어 있음.
    let popup: PopupBannerPolicy
    
    init(defaultBanner: DefaultBannerPolicy, popup: PopupBannerPolicy) {
        self.defaultBanner = defaultBanner
        self.popup = popup
    }
    
    init(from model: [BannerPolicyItemModel]) {
        // TODO: 이렇게 하면 두바퀴를 돔. 성능에 문제가 있을시 수정 필요.
        self.defaultBanner = DefaultBannerPolicy(from: model)
        self.popup = PopupBannerPolicy(from: model)
    }
}
