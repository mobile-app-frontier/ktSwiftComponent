//
//  BannerPolicyState.swift
//  GeniePhone
//
//  Created by 이소정 on 2023/04/11.
//

import Foundation
import Utils

/// `BannerPolicyFetcher` 의 상태
/// 
/// - `initial`: 초기 상태
/// - `fetched`: remoteBannerPolicy 와 localBannerPolicy 를 fetch 완료한 상태.
/// - `success`: remoteBannerPolicy 와 localBannerPolicy 를 비교하여 보여줄 배너를 filtering 완료한 상태.
/// - `fail`: error 가 발생하여 fail 한 상태.
public enum BannerPolicyState {
    /// 초기 상태
    case initial
    
    /// remoteBannerPolicy 와 localBannerPolicy 를 fetch 완료한 상태.
    /// - Parameter remoteBanner: 서버에서 받아온 Banner Policy.
    /// - Parameter localBanner: 단말에서 읽어온 Banner Policy.
    case fetched(remoteBanner: BannerPolicy, localBanner: LocalBannerPolicy)
    
    
    /// remoteBannerPolicy 와 localBannerPolicy 를 비교하여 보여줄 배너를 filtering 완료한 상태.
    /// - Parameter willShowBanner: 서버에서 받아온 배너 정책과 단말에서 읽어온 배너 정책을 비교하여 얻어온 보여줄 배너 정책.
    case success(willShowBanner: BannerPolicy)
    
    /// 배너 정책을 가져오는데 실패한 상태
    /// - Parameter Error: 에러
    case fail(Error)
    
    /// `success` 상태에서만 willShowBanner return. 이외의 상태에서는 nil 을 return.
    internal var willShowBanner: BannerPolicy? {
        switch self {
        case .success(let willShowBanner):
            return willShowBanner
        default:
            return nil
        }
    }
    
    internal func equals(version: Version?, appVersion: Version) -> Bool {
        if let version = version {
            return version == appVersion
        }
        else {
            return true
        }
    }
    
    internal func isWillShow(notShowUntil: Int?) -> Bool {
        guard let notShowUntil = notShowUntil else {
            return true
        }
        let notShowUntilDate = Date(timeIntervalSince1970: TimeInterval(notShowUntil))
        
        return Date() > notShowUntilDate
    }
}
