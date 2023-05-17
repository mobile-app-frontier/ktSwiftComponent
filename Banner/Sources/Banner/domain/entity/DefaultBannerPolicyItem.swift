//
//  DefaultBannerPolicyItem.swift
//  GeniePhone
//
//  Created by 이소정 on 2023/04/10.
//

import Foundation
import Utils

public struct DefaultBannerPolicyItem: BannerPolicyItem {
    public static func < (lhs: DefaultBannerPolicyItem, rhs: DefaultBannerPolicyItem) -> Bool {
        lhs.priority < rhs.priority
    }
    
    public static func == (lhs: DefaultBannerPolicyItem, rhs: DefaultBannerPolicyItem) -> Bool {
        lhs.id == rhs.id
    }
    
    /// BannerPolicyItem protocol.
    public let id: String
    public let priority: Int
    public let targetAppversion: Version?
    public let landingType: BannerLandingType
    public let additionalInfo: [String : String]?
    
    /// `content`: Banner content. image 타입만 존재
    public let content: DefaultBannerPolicyItem.Content
    /// `category`: Banner 가 속하는 category. category 별로 배너를 모아서 보여줌.
    public let category: String
    
    init(id: String,
         priority: Int,
         targetAppversion: Version?,
         landingType: BannerLandingType,
         content: DefaultBannerPolicyItem.Content,
         category: String,
         additionalInfo: [String : String]? = nil
    ) {
        self.id = id
        self.priority = priority
        self.targetAppversion = targetAppversion
        self.landingType = landingType
        self.content = content
        self.category = category
        self.additionalInfo = additionalInfo
    }
    
    public init(from model: BannerPolicyItemModel) {
        self.init(id: model.id,
                  priority: model.priority,
                  targetAppversion: model.appVersion != nil ? Version(model.appVersion!) : nil,
                  landingType: BannerLandingType.fromString(model.landingType, url: model.landingDestination),
                  content: DefaultBannerPolicyItem.Content.fromString(model.content),
                  category: model.category ?? String(),
                  additionalInfo: model.additionalInfo
        )
    }
 
    public enum Content {
        case image(url: String)
        
        public static func fromString(_ rawValue: String) -> Content{
            return .image(url: rawValue)
        }
        
        var url: URL? {
            switch self {
            case .image(let url):
                return URL(string: url)
            }
        }
    }
}
