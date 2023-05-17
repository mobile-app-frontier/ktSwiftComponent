//
//  PopupBannerPolicyItem.swift
//  GeniePhone
//
//  Created by 이소정 on 2023/04/10.
//

import Foundation
import Utils

public struct PopupBannerPolicyItem: BannerPolicyItem {
    public static func == (lhs: PopupBannerPolicyItem, rhs: PopupBannerPolicyItem) -> Bool {
        lhs.id == rhs.id
    }
    
    public static func < (lhs: PopupBannerPolicyItem, rhs: PopupBannerPolicyItem) -> Bool {
        lhs.priority < rhs.priority
    }
    
    /// BannerPolicyItem protocol.
    public let id: String
    public let priority: Int
    public let targetAppversion: Version?
    public let landingType: BannerLandingType
    public let additionalInfo: [String : String]?
    
    /// `content`: Banner Content. text / html / image
    public let content: PopupBannerPolicyItem.Content
    /// `closeType`: Banner 가 닫히는 옵션. closeOnly / nerverShowAgain / notShowForWeek / notShowToday
    public let closeType: BannerCloseType
    
    init(id: String,
         priority: Int,
         targetAppversion: Version?,
         landingType: BannerLandingType,
         content: PopupBannerPolicyItem.Content,
         closeType: BannerCloseType,
         additionalInfo: [String : String]? = nil
    ){
        self.id = id
        self.priority = priority
        self.targetAppversion = targetAppversion
        self.landingType = landingType
        self.content = content
        self.closeType = closeType
        self.additionalInfo = additionalInfo
    }
    
    public init(from model: BannerPolicyItemModel) {
        self.init(id: model.id,
                  priority: model.priority,
                  targetAppversion: model.appVersion != nil ? Version(model.appVersion!) : nil,
                  landingType: BannerLandingType.fromString(model.landingType, url: model.landingDestination),
                  content: PopupBannerPolicyItem.Content.fromModel(type: model.contentType, content: model.content),
                  closeType: BannerCloseType.fromString(model.closeType),
                  additionalInfo: model.additionalInfo
        )
    }
    
    public enum Content {
        case text(String)
        case html(String)
        case image(url: String)
        
        static func fromModel(type: String, content: String) -> Content {
            switch type {
            case "T":
                return .text(content)
            case "H":
                return .html(content)
            case "I":
                return .image(url: content)
            default:
                return .text(content)
            }
        }
    }
}




