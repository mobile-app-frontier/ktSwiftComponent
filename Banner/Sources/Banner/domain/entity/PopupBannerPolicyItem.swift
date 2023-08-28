//
//  PopupBannerPolicyItem.swift
//  GeniePhone
//
//  Created by 이소정 on 2023/04/10.
//

import Foundation
import Utils

/// Popup Banner
public struct PopupBannerPolicyItem: BannerPolicyItem {
    public static func == (lhs: PopupBannerPolicyItem, rhs: PopupBannerPolicyItem) -> Bool {
        lhs.id == rhs.id
    }
    
    public static func < (lhs: PopupBannerPolicyItem, rhs: PopupBannerPolicyItem) -> Bool {
        lhs.priority < rhs.priority
    }
    
    /// BannerPolicyItem protocol.
    internal let id: String
    internal let priority: Int
    internal let targetAppversion: Version?
    internal let landingType: BannerLandingType
    internal let additionalInfo: [String : String]?
    
    /// `content`: Banner Content. text / html / image
    internal let content: PopupBannerPolicyItem.Content
    /// `closeType`: Banner 가 닫히는 옵션. closeOnly / nerverShowAgain / notShowForWeek / notShowToday
    internal let closeType: BannerCloseType
    
    internal init(id: String,
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
    
    internal init(from model: BannerPolicyItemModel) {
        self.init(id: model.id,
                  priority: model.priority,
                  targetAppversion: model.appVersion != nil ? Version(model.appVersion!) : nil,
                  landingType: BannerLandingType.fromString(model.landingType, url: model.landingDestination),
                  content: PopupBannerPolicyItem.Content.fromModel(type: model.contentType, content: model.content),
                  closeType: BannerCloseType.fromString(model.closeType),
                  additionalInfo: model.additionalInfo
        )
    }
    
    internal enum Content {
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




