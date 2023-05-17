// Version.swift
// GeniePhone
//
// Created by 이소정 on 2023/04/11.
//

import Foundation
/// 지원하는 버전 포멧: major.minor.patch(-preRelease)
/// https://semver.org/
/// ex. 1.6.1, 2.10.4-beta
///
/// 주의!: 버전 비교 시에는 preRelease 는 확인하지 않는다.
/// 지원하지 않는 포멧인 경우 FormatException 을 발생시킨다.
public struct Version: Comparable {
    public let major: Int
    public let minor: Int
    public let patch: Int
    
    public let preRelease: String?
    
    public static func getAppVersion() -> Version {
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        let buildVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as! String
        return Version(appVersion + "-" + buildVersion)
    }
    
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
    
    public init(major: Int, minor: Int, patch: Int, preRelease: String?) {
        self.major = major
        self.minor = minor
        self.patch = patch
        self.preRelease = preRelease
    }
    
    public static func == (lhs: Version, rhs: Version) -> Bool {
        return (lhs.major == rhs.major) && (lhs.minor == rhs.minor) && (lhs.patch == rhs.patch)
    }
    
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
