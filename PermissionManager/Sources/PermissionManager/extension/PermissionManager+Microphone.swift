//
//  PermissionManager+Locator.swift
//  GeniePhone
//
//  Created by pjx on 2023/02/07.
//

import Foundation
import AVFoundation

///Privacy - Microphone Usage Description
/// NSMicrophoneUsageDescription
extension PermissionManager {
    internal func checkMicroPhonePermission() -> PermissionCondition {
        switch AVAudioSession.sharedInstance().recordPermission {
        case .granted:
            return .granted(.mic)
        case .undetermined:
            return .undetermined
        case .denied:
            return .denied
        @unknown default:
            return .denied
        }
    }
    
    internal func requestMicroPhonePermission() async -> PermissionCondition {
        do {
            return try await withCheckedThrowingContinuation({ continuation in
                AVAudioSession.sharedInstance().requestRecordPermission { granted in
                    continuation.resume(
                        returning: granted
                        ? .granted(.mic)
                        : .denied
                    )
                }
            })
        } catch {
            debugPrint("requestMicroPhonePermission exception \(error.localizedDescription)")
            return .denied
        }
    }
}
