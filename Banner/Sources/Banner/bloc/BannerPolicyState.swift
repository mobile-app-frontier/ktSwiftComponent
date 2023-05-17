//
//  BannerPolicyState.swift
//  GeniePhone
//
//  Created by 이소정 on 2023/04/11.
//

import Foundation
import Utils

public enum BannerPolicyState {
    /// `initial`: 초기 상태
    case initial
    /// `fetched`: remoteBannerPolicy 와 localBannerPolicy 를 fetch 완료한 상태.
    case fetched(remoteBanner: BannerPolicy, localBanner: LocalBannerPolicy)
    /// `success`: remoteBannerPolicy 와 localBannerPolicy 를 비교하여 보여줄 배너를 filtering 완료한 상태.
    case success(willShowBanner: BannerPolicy)
    /// `fail`: errpr 가 발생하여 fail 한 상태.
    case fail(Error)
    
    /// `success` 상태에서만 willShowBanner return. 이외의 상태에서는 nil 을 return.
    public var willShowBanner: BannerPolicy? {
        switch self {
        case .success(let willShowBanner):
            return willShowBanner
        default:
            return nil
        }
    }
    
    func equals(version: Version?, appVersion: Version) -> Bool {
        if let version = version {
            return version == appVersion
        }
        else {
            return true
        }
    }
    
    func isWillShow(notShowUntil: Int?) -> Bool {
        guard let notShowUntil = notShowUntil else {
            return true
        }
        let notShowUntilDate = Date(timeIntervalSince1970: TimeInterval(notShowUntil))
        
        return Date() > notShowUntilDate
    }
}
