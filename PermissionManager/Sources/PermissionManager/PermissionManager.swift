//
//  PermissionManager.swift
//  GeniePhone
//
//  Created by pjx on 2023/02/06.
//

import Foundation
import UIKit


public class PermissionManager {
    
    public static let instance: PermissionManager = PermissionManager()
    
    private init () {}
    
    public private(set) var permissionCondition:[PermissionType: PermissionCondition]  = [:]
    
}

//MARK: - check permission condition
extension PermissionManager {
    public func checkPermissions(permissions: [PMPermissionCheck]) async {
        for permission in permissions {
            _ = await currentPermissionCondition(permission)
        }
    }
    
    public func currentPermissionCondition(_ check:  PMPermissionCheck) async -> PermissionCondition {
        switch(check) {
        case .callKit:
            let condition = await checkCallKitPermission()
            permissionCondition[PermissionType.callKit] = condition
            return condition
        case .camera:
            let condition = checkCameraPermission()
            permissionCondition[PermissionType.camera] = condition
            return condition
        case .contact:
            let condition = checkContactPermission()
            permissionCondition[PermissionType.contacts] = condition
            return condition
        case .alwaysLocation:
            let condition = checkLocationPermission()
            permissionCondition[PermissionType.alwaysLocation] = condition
            return condition
        case .whenInUseLocation:
            let condition = checkLocationPermission()
            permissionCondition[PermissionType.whenInUseLocation] = condition
            return condition
        case .mic:
            let condition = checkMicroPhonePermission()
            permissionCondition[PermissionType.camera] = condition
            return condition
        case .notification:
            let condition = await checkNotificationPermission()
            permissionCondition[PermissionType.notification] = condition
            return condition
        case .photoLibrary(let options):
            let condition = checkPhotoLibraryPermission(request: options)
            if case .granted(let permissionType) = condition {
                permissionCondition[permissionType] = condition
            } else {
                permissionCondition[PermissionType.photoLibrary] = condition
                permissionCondition[PermissionType.photoLibraryLimited] = condition
            }
            return condition
        }
    }
}

//MARK: - request permission
extension PermissionManager {
    public func requestPermission(_ request: PMPermissionRequest) async -> PermissionCondition {
        switch(request) {
        case .callKit:
            return .notSupport(reason: "callkit request permission is not support function.(go to setting > call > call block & identifier)")
        case .camera:
            let condition = await requestCameraPermission()
            permissionCondition[PermissionType.camera] = condition
            return condition
        case .contact:
            let condition = await requestContactPermission()
            permissionCondition[PermissionType.contacts] = condition
            return condition
        case .whenInUseLocation, .alwaysLocation:
            return .notSupport(reason: "use in your localtion manager")
        case .mic:
            let condition = await requestMicroPhonePermission()
            permissionCondition[PermissionType.mic] = condition
            return condition
        case .notification(let options):
            let condition = await requestNotificaationPermission(options: options)
            permissionCondition[PermissionType.notification] = condition
            return condition
        case .photoLibrary(let options):
            let condition = await requestPhotoLibraryPermission(options: options)
            if case .granted(let permissionType) = condition {
                permissionCondition[permissionType] = condition
            } else {
                permissionCondition[PermissionType.photoLibrary] = condition
                permissionCondition[PermissionType.photoLibraryLimited] = condition
            }
            return condition
        }
    }
}
