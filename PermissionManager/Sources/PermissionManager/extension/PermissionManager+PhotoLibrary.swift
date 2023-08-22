//
//  PermissionManager+Photo.swift
//  GeniePhone
//
//  Created by pjx on 2023/02/07.
//

import Foundation
import Photos



extension PermissionManager {
    internal func checkPhotoLibraryPermission(request options: PHPhotoLibraryRequest?) -> PermissionCondition {
        let status: PHAuthorizationStatus
        
        if #available(iOS 14, *) {
            let level: PHAccessLevel
            switch options {
            case .addOnly:
                level = .addOnly
            case .readWrite:
                level = .readWrite
            case .none:
                level = .readWrite
            }
            status = PHPhotoLibrary.authorizationStatus(for: level)
        } else {
            status = PHPhotoLibrary.authorizationStatus()
        }
        
        
        switch status {
        case .denied, .restricted:
            return .denied
        case .notDetermined:
            return .undetermined
        case .authorized:
            return .granted(.photoLibrary)
        case .limited:
            return .granted(.photoLibraryLimited)
        @unknown default:
            return .denied
        }
    }
    
    func requestPhotoLibraryPermission(options: PHPhotoLibraryRequest?) async -> PermissionCondition {
        if #available(iOS 14, *) {
            let level: PHAccessLevel
            switch options {
            case .addOnly:
                level = .addOnly
            case .readWrite:
                level = .readWrite
            case .none:
                level = .readWrite
            }
            
            let status = await PHPhotoLibrary.requestAuthorization(for: level)
                    
            switch status {
            case  .notDetermined:
                return .undetermined
            case .denied, .restricted:
                return .denied
            case .authorized:
                return .granted(.photoLibrary)
            case .limited:
                return .granted(.photoLibraryLimited)
            @unknown default:
//                return .error(nil)
//                Log.e("requestPhotoLibraryPermission exception \(error.localizedDescription)")
                return .denied
            }
        } else {
            do {
                return try await withCheckedThrowingContinuation({ continuation in
                    PHPhotoLibrary.requestAuthorization { status in
                        switch status {
                        case .notDetermined:
                            continuation.resume(returning: .undetermined)
                        case .denied, .restricted:
                            continuation.resume(returning: .denied)
                        case .authorized:
                            continuation.resume(returning: .granted(.photoLibrary))
                        case .limited:
                            continuation.resume(returning: .granted(.photoLibraryLimited))
                        @unknown default:
                            continuation.resume(returning: .denied)
                        }
                    }
                })
            } catch {
                debugPrint("requestPhotoLibraryPermission exception \(error.localizedDescription)")
                return .denied
            }
            
        }
    }
}
