//
//  PriorityQueue+Initializer.swift
//  GeniePhone
//
//  Created by 이소정 on 2023/04/11.
//

import Foundation

// PopupBannerPolicy 는 priority 을 기준으로 내림차순 정렬되어 있음.
internal typealias PopupBannerPolicy = PriorityQueue<PopupBannerPolicyItem>

internal extension PopupBannerPolicy {
    init() {
        self.init([], >)
    }
    
    init(from model: [BannerPolicyItemModel]) {
        self.init( model
            .filter{ $0.type == "popup" }
            .map { PopupBannerPolicyItem(from: $0) }, >)
    }
}
