//
//  DefaultBannerPolicyItem.swift
//  GeniePhone
//
//  Created by 이소정 on 2023/04/10.
//

import Foundation
import Utils

internal struct DefaultBannerPolicyItem: BannerPolicyItem {
    internal static func < (lhs: DefaultBannerPolicyItem, rhs: DefaultBannerPolicyItem) -> Bool {
        lhs.priority < rhs.priority
    }
    
    internal static func == (lhs: DefaultBannerPolicyItem, rhs: DefaultBannerPolicyItem) -> Bool {
        lhs.id == rhs.id
    }
    
    /// BannerPolicyItem protocol.
    internal let id: String
    internal let priority: Int
    internal let targetAppversion: Version?
    internal let landingType: BannerLandingType
    internal let additionalInfo: [String : String]?
    
    /// `content`: Banner content. image 타입만 존재
    internal let content: DefaultBannerPolicyItem.Content
    /// `category`: Banner 가 속하는 category. category 별로 배너를 모아서 보여줌.
    internal let category: String
    
    internal init(id: String,
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
    
    internal init(from model: BannerPolicyItemModel) {
        self.init(id: model.id,
                  priority: model.priority,
                  targetAppversion: model.appVersion != nil ? Version(model.appVersion!) : nil,
                  landingType: BannerLandingType.fromString(model.landingType, url: model.landingDestination),
                  content: DefaultBannerPolicyItem.Content.fromString(model.content),
                  category: model.category ?? String(),
                  additionalInfo: model.additionalInfo
        )
    }
 
    internal enum Content {
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
