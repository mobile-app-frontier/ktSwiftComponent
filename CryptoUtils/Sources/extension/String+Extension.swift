//
//  String+Crypto.swift
//  GeniePhone
//
//  Created by kh Jang on 2023/04/11.
//

import Foundation
import CryptoKit

extension String {
    public var bytes: Array<UInt8> {
        self.data(using: .utf8, allowLossyConversion: true)?.bytes ?? Array(utf8)
    }
    
    public func sha256() -> String {
        self.bytes.sha256().toHexString()
    }
    
    public func sha512() -> String {
        self.bytes.sha512().toHexString()
    }
    
    public func toBase64String() throws -> String {
        let lines = self.components(separatedBy: "\n").filter { line in
            return !line.hasPrefix("-----BEGIN") && !line.hasPrefix("-----END")
        }
        
        guard lines.count != 0 else {
            throw RSAError.pemDoesNotContainKey
        }
        
        return lines.joined(separator: "")
    }
}

extension Array where Element == UInt8 {
    public func sha256() -> [Element] {
        Digest.sha256(self)
    }
    public func sha512() -> [Element] {
        Digest.sha512(self)
    }
    
    public func toHexString() -> String {
        self.map{String($0, radix: 16)}.joined()
    }
}

public struct Digest {
    static func sha256(_ bytes: Array<UInt8>) -> Array<UInt8> {
        let hashList = SHA256.hash(data: bytes)
        return Array(hashList)
    }
    static func sha512(_ bytes: Array<UInt8>) -> Array<UInt8> {
        let hashList = SHA512.hash(data: bytes)
        return Array(hashList)
    }
}
