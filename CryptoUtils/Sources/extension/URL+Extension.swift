//
//  URL+Extension.swift
//  
//
//  Created by kh Jang on 2023/05/10.
//

import Foundation
import CryptoKit

// TODO: IO 발생하는데 async하게 사용하도록 변경
extension URL {
    /// URL 파일 Data 암호화
    /// - Parameters:
    ///   - keyData: 데이터 형태의 키
    ///   - cipher: 키 타입에 따라 AES(대칭)/RSA(비대칭) 사용
    public func encrypt(keyData: Data, cipher: any Cipher) throws {
        let fileData = try Data(contentsOf: self)
        //        let cipher = AESCipher(data: keyData, appId: Bundle.main.bundleIdentifier)
        
        // 데이터 암호화
        let encryptedData = try fileData.encrypt(cipher: cipher)
        
        // 암호화된 데이터를 파일 씀
        try encryptedData.write(to: self)
    }
    
    /// URL 파일 Data 복호화
    /// - Parameters:
    ///   - keyData: 데이터 형태의 키
    ///   - cipher: 키 타입에 따라 AES(대칭)/RSA(비대칭) 사용
    public func decrypt(keyData: Data, cipher: any Cipher) throws {
        let fileData = try Data(contentsOf: self)

        let data = try fileData.decrypt(cipher: cipher)
        try data.write(to: self)
    }
}
