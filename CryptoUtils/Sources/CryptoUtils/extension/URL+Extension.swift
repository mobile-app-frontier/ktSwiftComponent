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
    // url extension
    public func encrypt(keyData: Data, cipher: any Cipher) throws {
        let fileData = try Data(contentsOf: self)
        //        let cipher = AESCipher(data: keyData, appId: Bundle.main.bundleIdentifier)
        
        // 데이터 암호화
        let encryptedData = try fileData.encrypt(cipher: cipher)
        
        // 암호화된 데이터를 파일 씀
        try encryptedData.write(to: self)
    }
    
    public func decrypt(keyData: Data, cipher: any Cipher) throws {
        let fileData = try Data(contentsOf: self)

        let data = try fileData.decrypt(cipher: cipher)
        try data.write(to: self)
    }
}
