//
//  PermissionManager+CallKit.swift
//  GeniePhone
//
//  Created by pjx on 2023/02/14.
//

import Foundation
import CallKit

extension PermissionManager {
    
    func checkCallKitPermission() async -> PermissionCondition {
        return await withCheckedContinuation { continuation in
            CXCallDirectoryManager.sharedInstance.getEnabledStatusForExtension(withIdentifier: "") { state, error in
                
                if error != nil {
                    debugPrint("checkCameraPermission exception \(error!.localizedDescription)")
                    continuation.resume(returning: .denied)
                    return
                }
                
                switch state {
                case .enabled:
                    continuation.resume(returning: .granted(.callKit))
                case .disabled:
                    continuation.resume(returning: .denied)
                case .unknown:
                    continuation.resume(returning: .undetermined)
                @unknown default:
                    continuation.resume(returning: .denied)
                }
            }
        }
    }
}
