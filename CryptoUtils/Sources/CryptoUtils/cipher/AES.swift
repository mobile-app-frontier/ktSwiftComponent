//
//  File.swift
//  
//
//  Created by kh Jang on 2023/04/28.
//

import Foundation
import CryptoKit

// 대칭키 사용
// 속도가 빨라서 대용량 데이터 암호화에 적합
public struct AESCipher: Cipher {
    public let key: SymmetricKey

    // 특정 데이터로 생성할 때(ex. 서버에서 받은 키 키체인에 저장하고 암/복호화 하고싶을 때)
    public init(symmetricKey: SymmetricKey) {
        self.key = symmetricKey
    }
}

//MARK: - implement Cipher 
extension AESCipher {
    // encrypt
    public func encrypt(originalData: Data) throws -> Data {
        let sealedBox = try AES.GCM.seal(originalData, using: key)
        return sealedBox.combined ?? (sealedBox.nonce + sealedBox.ciphertext + sealedBox.tag)
    }
    
    public func decrypt(encryptedData: Data) throws -> Data {
        let sealedBox = try AES.GCM.SealedBox(combined: encryptedData)
        return try AES.GCM.open(sealedBox, using: key)
    }
}

