//
//  PermissionManager+Camera.swift
//  GeniePhone
//
//  Created by pjx on 2023/02/07.
//

import Foundation
import AVFoundation


/// add Privacy - Camera Usage Description in  iplst
/// raw key : NSCameraUsageDescription
///
extension PermissionManager {
    internal func checkCameraPermission() -> PermissionCondition {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            return .granted(.camera)
        case .denied, .restricted:
            return .denied
        case .notDetermined:
            return .undetermined
        @unknown default:
            return .denied
        }
    }
    
    internal func requestCameraPermission() async -> PermissionCondition {
        do {
            return try await withCheckedThrowingContinuation({ continuation in
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    return granted
                    ? continuation.resume(returning: .granted(.camera))
                    : continuation.resume(returning: .denied)
                }
            })
        }catch {
            debugPrint("requestCameraPermission exception \(error.localizedDescription)")
            return .denied
        }
    }

}
