//
//  HapticManager.swift
//  GeniePhone
//
//  Created by 이소정 on 2023/03/21.
//

import SwiftUI

// https://velog.io/@j_aion/SwiftUI-Haptics
internal class HapticManager {
    internal static let instance = HapticManager()
    private init() {}
    
    internal func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    internal func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
