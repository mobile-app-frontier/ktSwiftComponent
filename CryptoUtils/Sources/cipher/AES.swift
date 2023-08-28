//
//  File.swift
//  
//
//  Created by kh Jang on 2023/04/28.
//

import Foundation
import CryptoKit

/// 대칭키 암호를 사용하여 암/복호화 시 사용
/// 속도 빠름 대용량 처리에 유용함.
/// 현재 대칭키 중 가장 암호화 수준이 높은 AES GCM 알고리즘을 사용.
public struct AESCipher: Cipher {
    public let key: SymmetricKey

    // 특정 데이터로 생성할 때(ex. 서버에서 받은 키 키체인에 저장하고 암/복호화 하고싶을 때)
    
    /// 사용할 대칭키로 초기화
    /// - Parameter symmetricKey: [Cryptokit](https://developer.apple.com/documentation/cryptokit/)의 SymmetricKey 사용
    public init(symmetricKey: SymmetricKey) {
        self.key = symmetricKey
    }
}

//MARK: - implement Cipher 
extension AESCipher {
    
    /// 암호화 함수
    /// - Parameter originalData: 원본 데이터
    /// - Returns: 암호화 된 데이터
    public func encrypt(originalData: Data) throws -> Data {
        let sealedBox = try AES.GCM.seal(originalData, using: key)
        return sealedBox.combined ?? (sealedBox.nonce + sealedBox.ciphertext + sealedBox.tag)
    }
    
    /// 복호화
    /// - Parameter encryptedData: 암호화된 데이터
    /// - Returns: 복호화 된 데이터
    public func decrypt(encryptedData: Data) throws -> Data {
        let sealedBox = try AES.GCM.SealedBox(combined: encryptedData)
        return try AES.GCM.open(sealedBox, using: key)
    }
}

