// Version.swift
// GeniePhone
//
// Created by 이소정 on 2023/04/11.
//

import Foundation

/// [Semantic Versioning](https://semver.org/)
///
///  지원하는 버전 format
///
///  major.minor.patch(-preRelease)
///
///  ex. 1.6.1, 2.10.4-beta
///  
///  - Important: 버전 비교 시에는 preRelease 는 확인 하지 않는다. 지원하지 않는 format인 경우 `FormatException` 을 발생시킨다.
public struct Version: Comparable {
    /// version when you mamke incompatible API changes
    public let major: Int
    
    /// version when you add functionality in a backward compatible manner
    public let minor: Int
    
    /// version when you make backward compatible bug fixes
    public let patch: Int
    
    /// Identifiers MUST comprise only ASCII alphanumerics and hyphens [0-9A-Za-z-]. Identifiers MUST NOT be empty. Numeric identifiers MUST NOT include leading zeroes. 
    ///
    /// Pre-release versions have a lower precedence than the associated normal version. A pre-release version indicates that the version is unstable and might not satisfy the intended compatibility requirements as denoted by its associated normal version. Examples: 1.0.0-alpha, 1.0.0-alpha.1, 1.0.0-0.3.7, 1.0.0-x.7.z.92, 1.0.0-x-y-z.
    public let preRelease: String?
    
    
    /// Bundle 에서 현재 앱 버전 정보를 읽어옴.
    /// - Returns: 현재 App Version
    public static func getAppVersion() -> Version {
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        let buildVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as! String
        return Version(appVersion + "-" + buildVersion)
    }
    
    /// Semantic Versioning rule 를 따르는 `String` 버전 정보를 통한 initializer.
    /// - Parameter version: Semantic Versioning rule 를 따르는 String
    /// - Important: SemVer rule 를 따르지 않을 경우 `FormatException` 이 발생할 수 있다.
    public init(_ version: String) {
        guard !version.isEmpty else {
            self.init(major: 0, minor: 0, patch: 0, preRelease: nil)
            return
        }
        let splitParts = version.split(separator: "-")
        let splitVersion = splitParts[0].split(separator: ".")
        let major = Int(splitVersion[0])
        let minor = Int(splitVersion[1])
        let patch = Int(splitVersion[2])
        let preRelease = splitParts.count > 1 ? String(splitParts[1]) : nil
        guard let major = major, let minor = minor, let patch = patch else {
            self.init(major: 0, minor: 0, patch: 0, preRelease: nil)
            return
        }
        self.init(major: major, minor: minor, patch: patch, preRelease: preRelease)
    }
    
    /// major, minor, patch, preRelease Initializer
    /// - Parameters:
    ///   - major: version when you mamke incompatible API changes
    ///   - minor: version when you add functionality in a backward compatible manner
    ///   - patch: version when you make backward compatible bug fixes
    ///   - preRelease: preRelease version. optional value
    public init(major: Int, minor: Int, patch: Int, preRelease: String? = nil) {
        self.major = major
        self.minor = minor
        self.patch = patch
        self.preRelease = preRelease
    }
    
    /// 두 개의 `Version` 을 받아 `major`, '`minor`, `patch` 가 모두 같은지를 비교한다.
    /// - Parameters:
    ///   - lhs: 비교할 `Version`
    ///   - rhs: 비교할 `Version`
    /// - Returns: 같으면 `true` 다르면 `false`
    public static func == (lhs: Version, rhs: Version) -> Bool {
        return (lhs.major == rhs.major) && (lhs.minor == rhs.minor) && (lhs.patch == rhs.patch)
    }
    
    /// 두 개의 `Version` 을 받아 `major`, '`minor`, `patch` 순으로 왼쪽이 오른쪽보다 작은지를 비교한다.
    /// - Parameters:
    ///   - lhs: 비교할 `Version`
    ///   - rhs: 비교할 `Version`
    /// - Returns: 왼쪽이 더 작으면 `true` 더 크거나 같으면 `false`
    public static func < (lhs: Version, rhs: Version) -> Bool {
        if (lhs.major != rhs.major) {
            return lhs.major < rhs.major
        }
        else if (lhs.minor != rhs.minor) {
            return lhs.minor < rhs.minor
        }
        else {
            return lhs.patch < rhs.patch
        }
    }
    
    /// 두 개의 `Version` 을 받아 `major`, '`minor`, `patch` 순으로 왼쪽이 오른쪽보다 작거나 같은지를 비교한다.
    /// - Parameters:
    ///   - lhs: 비교할 `Version`
    ///   - rhs: 비교할 `Version`
    /// - Returns: 왼쪽이 더 작거나 같으면  `true` 더 크면 `false`
    public static func <= (lhs: Version, rhs: Version) -> Bool {
        if (lhs.major != rhs.major) {
            return lhs.major <= rhs.major
        }
        else if (lhs.minor != rhs.minor) {
            return lhs.minor <= rhs.minor
        }
        else {
            return lhs.patch <= rhs.patch
        }
    }
    
    /// 두 개의 `Version` 을 받아 `major`, '`minor`, `patch` 순으로 왼쪽이 오른쪽보다 큰지를 비교한다.
    /// - Parameters:
    ///   - lhs: 비교할 `Version`
    ///   - rhs: 비교할 `Version`
    /// - Returns: 왼쪽이 더 크면 `true` 더 작거나 같으면 `false`
    public static func > (lhs: Version, rhs: Version) -> Bool {
        if (lhs.major != rhs.major) {
            return lhs.major > rhs.major
        }
        else if (lhs.minor != rhs.minor) {
            return lhs.minor > rhs.minor
        }
        else {
            return lhs.patch > rhs.patch
        }
    }
    
    /// 두 개의 `Version` 을 받아 `major`, '`minor`, `patch` 순으로 왼쪽이 오른쪽보다 크거나 같은지를 비교한다.
    /// - Parameters:
    ///   - lhs: 비교할 `Version`
    ///   - rhs: 비교할 `Version`
    /// - Returns: 왼쪽이 더 크거나 같으면 `true` 더 작으면 `false`
    public static func >= (lhs: Version, rhs: Version) -> Bool {
        if (lhs.major != rhs.major) {
            return lhs.major >= rhs.major
        }
        else if (lhs.minor != rhs.minor) {
            return lhs.minor >= rhs.minor
        }
        else {
            return lhs.patch >= rhs.patch
        }
    }
}
