//
//  PermissionManager+Notification.swift
//  GeniePhone
//
//  Created by pjx on 2023/02/07.
//

import Foundation
import UserNotifications

extension PermissionManager {
    
    
    func checkNotificationPermission() async -> PermissionCondition {
        let notificationCenter = UNUserNotificationCenter.current()
        let settings = await notificationCenter.notificationSettings()
        
        
        switch settings.authorizationStatus {
        case .notDetermined:
            return .undetermined
        case .denied, .provisional:
            return .denied
        case .authorized:
            return .granted(.notification)
        case .ephemeral:
            return .denied
        @unknown default:
            return .denied
        }
    }
    
    func requestNotificaationPermission(options: UNAuthorizationOptions) async -> PermissionCondition {
        
        guard ProcessInfo.processInfo.environment["SIMULATOR_DEVICE_NAME"] == nil else {
            debugPrint("[requestNotificaationPermission] Device is simulator. Simulator not supported notifications")
//            return .failure(.error(text: "Device is simulator. Simulator not supported notifications"))
            return .notSupport(reason: "Device is simulator. Simulator not supported notifications")
        }
        
        do {
            let notificationCenter = UNUserNotificationCenter.current()
            
            let requestResult = try await notificationCenter.requestAuthorization(options: options)
            
            if(requestResult) {
                return .granted(.notification)
            } else {
                return .denied
            }
        } catch {
            debugPrint("requestNotificaationPermission exception \(error.localizedDescription)")
            return .denied
        }
    }
}
