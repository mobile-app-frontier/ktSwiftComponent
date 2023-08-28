//
//  Data+Extension.swift
//  GeniePhone
//
//  Created by kh Jang on 2023/04/11.
//

import Foundation
import CryptoKit

extension Data {
    public var bytes: [UInt8] {
        return [UInt8](self)
    }
    
    public func checksum() -> UInt16 {
        let s = self.withUnsafeBytes { buf in
            return buf.lazy.map(UInt32.init).reduce(UInt32(0), +)
        }
        return UInt16(s % 65535)
    }
    
    public func sha256() -> Data {
        return Data(Digest.sha256(self.bytes))
    }
    
    public func decrypt(cipher: any Cipher) throws -> Data {
        return try cipher.decrypt(encryptedData: self)
    }
    
    public func encrypt(cipher: any Cipher) throws -> Data {
        return try cipher.encrypt(originalData: self)
    }
}
