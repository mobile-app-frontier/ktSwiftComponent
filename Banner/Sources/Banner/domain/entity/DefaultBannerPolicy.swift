//
//  DefaultBannerPolicy.swift
//  GeniePhone
//
//  Created by 이소정 on 2023/04/11.
//

import Foundation

// DefaultBannerPolicy 는 category 를 key 로 사용하고 있으며, key 에 매칭되는 [DefaultBannerPolicyItem]. DefaultBannerPolicy 는 Bloc 에서 banner filtering 시에 정렬이 되므로, 현재 정렬되어 있지 않음.
internal typealias DefaultBannerPolicy = [String:[DefaultBannerPolicyItem]]

internal extension DefaultBannerPolicy {
    init(from model: [BannerPolicyItemModel]) {
        var defaultBanner = DefaultBannerPolicy()
        
        model
            .filter { $0.type == "default" && $0.category != nil}
            .forEach {
                if (defaultBanner[$0.category!] == nil) {
                    defaultBanner[$0.category!] = [DefaultBannerPolicyItem(from: $0)]
                }
                else {
                    defaultBanner[$0.category!]?.append(DefaultBannerPolicyItem(from: $0))
                }
            }
        self = defaultBanner
    }
}
