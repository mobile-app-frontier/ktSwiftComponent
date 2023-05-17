//
//  BannerPolicyItemModel.swift
//  GeniePhone
//
//  Created by 이소정 on 2023/04/10.
//

import Foundation

public struct BannerPolicyItemModel: Codable {
    /// `id`: Banner Id
    public let id: String
    /// `priority`: Banner 우선순위. 우선순위가 높을수록 먼저 보여줌.
    public let priority: Int
    /// `contentType`: Popup Banner 는`I(image)`,`T(text)`, `H(html)`. Default Banner 는 `image`타입만 제공.
    public let contentType: String
    /// `content`: contentType 이  `image` 일 경우에는 imageUrl. `text`: content 내용. `html`: HTML 전문.
    public let content: String
    /// `landingType`:  landing 할 화면. landing 하지 않을 경우, nil.
    public let landingType: String?
    /// `landingDestination`: landingType 이 url 일 경우, 이동할 web view url.
    public let landingDestination: String?
    /// `closeType`: PopupBanner 에서 사용. `close`: 닫기. 한번보여주고 다시 보여주지 않음. `never`: 다시보지않기. `week`: 일주일동안 보지않기. `today`: 오늘은 보지 않기.
    public let closeType: String?
    /// `appVersion`: 해당 배너를 보여줄 AppVersion. nil 일 경우 모든 버전에서 보여짐.
    public let appVersion: String?
    /// `category`: Default Banner 에서 사용. Default Banner 일 경우, type 별로 BannerPolicyItem 을 묶어 제공.
    public let category: String?
    /// `type`: `popup`: popup 배너 `default`: 일반 배너.
    public let type: String
    
    /// `additionalInfo`: extra format.
    public let additionalInfo: [String: String]?
    
    public enum CodingKeys: String, CodingKey {
        case id
        case priority
        case contentType
        case content
        case landingType
        case landingDestination
        case closeType
        case appVersion
        case category
        case type
        case additionalInfo
    }
}
