//
//  BannerPolicyItemModel.swift
//  GeniePhone
//
//  Created by 이소정 on 2023/04/10.
//

import Foundation

/// 서버에서 받아온 BannerPolicyItem 의 raw 정보 Model
public struct BannerPolicyItemModel: Codable {
    /// 기본 생성자
    /// - Parameters:
    ///   - id: 배너 ID
    ///   - priority: 배너의 우선순위
    ///   - contentType: 배너 Content 의 종류
    ///   - content: 배너 내용
    ///   - landingType: 배너가 이동할 화면 정보
    ///   - landingDestination: 배너가 웹 뷰 landing 일 경우 webview url
    ///   - closeType: 배너가 닫히는 타입
    ///   - appVersion: 배너를 보여줄 app version
    ///   - category: 배너의 카테고리
    ///   - type: 배너의 종류
    ///   - additionalInfo: 배너에 대한 추가 정보
    public init(id: String, 
                priority: Int,
                contentType: String,
                content: String,
                landingType: String?,
                landingDestination: String?, 
                closeType: String?,
                appVersion: String?,
                category: String?,
                type: String,
                additionalInfo: [String : String]?
    ) {
        self.id = id
        self.priority = priority
        self.contentType = contentType
        self.content = content
        self.landingType = landingType
        self.landingDestination = landingDestination
        self.closeType = closeType
        self.appVersion = appVersion
        self.category = category
        self.type = type
        self.additionalInfo = additionalInfo
    }
    
    /// Banner Id
    public let id: String
    
    /// Banner 우선순위. 우선순위가 높을수록 먼저 보여줌.
    public let priority: Int
    
    /// Banner Content 의 종류
    ///
    /// Popup Banner 는`I(image)`,`T(text)`, `H(html)`.
    ///
    /// Default Banner 는 `image` 타입만 제공.
    public let contentType: String
    
    /// Banner 내용.
    ///
    /// `contentType`
    /// - `image`:  imageUrl.
    /// - `text`:  content 내용.
    /// - `html`:  HTML 전문.
    public let content: String
    
    /// landing 할 화면 혹은 `web`. landing 하지 않을 경우, nil.
    public let landingType: String?
    
    /// landingType 이 `web` 일 경우, 이동할 web view url.
    public let landingDestination: String?
    
    /// PopupBanner 를 닫을 때의 옵션
    ///
    /// `close`: 닫기. 한번 보여주고 다시 보여주지 않음.
    ///
    /// `never`: 다시 보지 않기.
    ///
    /// `week`: 일주일 동안 보지 않기.
    ///
    /// `today`: 오늘은 보지 않기.
    public let closeType: String?
    
    /// 해당 배너를 보여줄 AppVersion. nil 일 경우 모든 버전에서 보여짐.
    public let appVersion: String?
    
    
    /// Default Banner 에서 사용되는 Banner 의 Category.
    ///
    /// Default Banner 일 경우, category 별로 BannerPolicyItem 을 묶어 제공.
    public let category: String?
    
    
    /// 배너의 종류
    ///
    /// `popup`: popup 배너
    ///
    /// `default`: 일반 배너.
    public let type: String
    
    /// extra format
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
