//
//  PermissionManager+Location.swift
//  GeniePhone
//
//  Created by pjx on 2023/02/07.
//

import Foundation
import CoreLocation

///Privacy - Location Always Usage Description
/// NSLocationAlwaysUsageDescription
///
///Privacy - Location When In Use Usage Description
/// NSLocationWhenInUseUsageDescription
extension PermissionManager {
    internal func checkLocationPermission() -> PermissionCondition {
        guard CLLocationManager.locationServicesEnabled() else {
            return .notSupport(reason: "locationServices is disable")
        }
        
        let status: CLAuthorizationStatus
        
        if #available(iOS 14, *) {
            status = CLLocationManager().authorizationStatus
        } else {
            status = CLLocationManager.authorizationStatus()
        }
        
        switch status {
        case .notDetermined:
            return .undetermined
        case .restricted, .denied:
            return .denied
            
        case .authorizedWhenInUse:
            return .granted(.whenInUseLocation)
            
        case .authorizedAlways:
            return .granted(.alwaysLocation)
        @unknown default:
            return .denied
        }
    }
}
