//
//  PMModels.swift
//  GeniePhone
//
//  Created by 박주철 on 2023/02/08.
//

import Foundation
import UIKit


public enum PermissionCondition {
    case granted(PermissionType)
    case denied
    case undetermined
    case notSupport(reason:String?)
}


///Privacy - Photo Library Usage Description
/// NSPhotoLibraryUsageDescription
public enum PHPhotoLibraryRequest {
    case addOnly, readWrite
}

/// permission types
public enum PermissionType {
    /// call blocking permission
    case callKit
    /// user notification
    case notification
    /// microphone
    case mic
    /// camera
    case camera
    /// location
    case alwaysLocation, whenInUseLocation
    /// photo
    case photoLibrary, photoLibraryLimited
    case contacts
}

/// permission check param
public enum PMPermissionCheck {
    case callKit
    case notification
    case mic
    case camera
    case alwaysLocation
    case whenInUseLocation
    case contact
    case photoLibrary(PHPhotoLibraryRequest?)
}

/// permission request param
public enum PMPermissionRequest {
    case callKit
    case notification(UNAuthorizationOptions)
    case mic
    case camera
    case alwaysLocation
    case whenInUseLocation
    case contact
    case photoLibrary(PHPhotoLibraryRequest?)
}
