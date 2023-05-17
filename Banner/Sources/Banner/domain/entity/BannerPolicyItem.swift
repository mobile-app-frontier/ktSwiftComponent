//
//  BannerPolicyItem.swift
//  GeniePhone
//
//  Created by 이소정 on 2023/04/10.
//

import Foundation
import Utils

/// DefaultBanner 와 PopupBanner 의 공통 요소. BannerPolicyItem의 필수값.
protocol BannerPolicyItem: Comparable {
    /// `id`: Banner Id
    var id: String { get }
    /// `priority`: Banner 우선순위. 높은 우선순위를 가진것 부터 보여줌.
    var priority: Int { get }
    /// `targetAppversion`: Banner 를 보여줄 version. optional 이므로 없을 시에는 모든 버전에서 보여줌. 있을 경우는 해당 앱 버전에서만 보여줌.
    var targetAppversion: Version? { get }
    /// `landingType`: Banner 를 tap 했을 때 Landing 할 Type. .none / .inapp(destination) / web(url) 을 가질 수 있음.
    var landingType: BannerLandingType { get }
    /// `additionalInfo`: Banner package 에서 정의한 것 이외의 Info 가 더 있을 경우, Dictionary 형태로 가지고 있음. 사용하지는 않음.
    var additionalInfo: [String : String]? { get }
}

public enum BannerCloseType {
    case closeOnly // 닫기 옵션 하나만 존재. 한번 닫히면 다시 보여주지 않음.
    case nerverShowAgain // 다시 보지 않기, 닫기 옵션이 존재.
    case notShowForWeek // 일주일 동안 보지 않기, 닫기 옵션이 존재.
    case notShowToday // 오늘 하루 보지 않기, 닫기 옵션이 존재.
    
    static func fromString(_ rawValue: String?) -> BannerCloseType {
        guard let rawValue = rawValue else {
            return .closeOnly
        }
        
        switch rawValue {
        case "close":
            return .closeOnly
        case "never":
            return .nerverShowAgain
        case "week":
            return .notShowForWeek
        case "today":
            return .notShowToday
        default:
            return .closeOnly
        }
    }
    
    var notShowedDate: Date {
        switch self {
        case .closeOnly:
            return Date.distantFuture
        case .nerverShowAgain:
            return Date.distantFuture
        case .notShowToday:
            return Date().addingTimeInterval(86400)
        case .notShowForWeek:
            let oneWeekInSeconds: TimeInterval = 7 * 24 * 60 * 60 // 1주일은 7일 x 24시간 x 60분 x 60초
            return Date().addingTimeInterval(oneWeekInSeconds)
        }
    }
    
    var title: String {
        switch self {
        case .closeOnly:
            return ""
        case .nerverShowAgain:
            return "다시 보지 않기"
        case .notShowForWeek:
            return "일주일간 보지 않기"
        case .notShowToday:
            return "오늘은 보지 않기"
        }
    }
}

public enum BannerLandingType {
    case none
    case web(url: String) // webview Landing 일 경우 landing 할 url 을 가지고 있음.
    case inApp(destination: String) // App 내의 화면 전환일 경우, destination 을 가지고 있음.
    
    static func fromString(_ rawValue: String?, url: String?) -> BannerLandingType {
        guard let rawValue = rawValue else {
            return .none
        }
        
        switch rawValue {
        case "":
            return .none
        case "none":
            return .none
        case "web":
            guard let url = url else {
                return .none
            }
            return .web(url: url)
        default:
            return .inApp(destination: rawValue)
        }
    }
}
