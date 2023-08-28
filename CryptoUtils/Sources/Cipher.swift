//
//  Cipher.swift
//  
//
//  Created by kh Jang on 2023/04/28.
//

import Foundation

/// encrypt, decrypt protocol
/// 
public protocol Cipher {
    /// cipher key
    associatedtype KeyType
    var key: KeyType { get }
    
    /// encrypt data
    func encrypt(originalData: Data) throws -> Data
    
    /// decrypt data
    func decrypt(encryptedData: Data) throws -> Data
}
