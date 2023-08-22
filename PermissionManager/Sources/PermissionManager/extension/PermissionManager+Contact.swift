//
//  PermissionManager+Contact.swift
//  GeniePhone
//
//  Created by pjx on 2023/02/07.
//

import Foundation
import Contacts

///
/// INFOPLIST_KEY_NSContactsUsageDescription = 주소록 접근 권한 필요
///INFOPLIST_KEY_NSContactsUsageDescription = 주소록 접근 권한 필요

extension PermissionManager {
    internal func checkContactPermission() -> PermissionCondition {
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized:
            return .granted(.contacts)
        case .notDetermined:
            return .undetermined
        case .denied, .restricted:
            return .denied
        @unknown default:
            return .denied
        }
    }
    
    internal func requestContactPermission() async -> PermissionCondition {
        do {
            if try await CNContactStore().requestAccess(for: .contacts) {
                return .granted(.contacts)
            } else {
                return .denied
            }
        } catch {
            debugPrint("requestContactPermission exception \(error.localizedDescription)")
            return .denied
        }
    }
}
