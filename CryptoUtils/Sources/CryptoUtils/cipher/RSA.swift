//
//  RSA.swift
//  GeniePhone
//
//  Created by kh Jang on 2023/04/11.
//

import Foundation
import Security

// 비대칭키 RSA 알고리즘 사용
// 대칭키 대비 속도가 아주 느림.
public struct RSACipher: Cipher {
    private let algorithm: SecKeyAlgorithm = .rsaEncryptionPKCS1
    
    /// encrypt public key
    private let publicKey: SecKey?
    public let key: SecKey?
    
    public init(privateKey: SecKey? = nil, publicKey: SecKey? = nil) {
        self.key = privateKey
        self.publicKey = publicKey
    }
    
    public func getPublicKey() throws -> SecKey {
        guard let publicKey = publicKey else {
            guard let privateKey = self.key else {
                throw RSAError.emptyPrivateKey
            }
            
            guard let pubKey = SecKeyCopyPublicKey(privateKey) else {
                throw RSAError.failedToCreatePubKey
            }
            return pubKey
        }
        
        return publicKey
    }
}

//MARK: - implement Cipher
extension RSACipher {
    
    // RSA 암호화
    public func encrypt(originalData: Data) throws -> Data {
        let publicKey = try getPublicKey()
        
        let algorithm: SecKeyAlgorithm = .rsaEncryptionPKCS1
        var encryptedData = Data()
        let blockSize = SecKeyGetBlockSize(publicKey) - 11
        if #available(iOS 15, *) {
            let buffers = makeBuffers(fromData: originalData, bufferSize: blockSize)
                
            for buffer in buffers {
                var encryptionError: Unmanaged<CFError>?
                
                guard let encryptedBuffer = SecKeyCreateEncryptedData(publicKey, algorithm, buffer as CFData, &encryptionError) as Data? else {
                    throw encryptionError!.takeRetainedValue() as Error
                }
                
                encryptedData.append(encryptedBuffer)
            }
        } else {
            var index = 0
            while index < originalData.count {
                let length = Swift.min(blockSize, originalData.count - index)
                let chunk = originalData.subdata(in: index..<index+length)
                var encryptedChunk = [UInt8](repeating: 0, count: blockSize)
                var encryptedLength = encryptedChunk.count
                let status = SecKeyEncrypt(publicKey, .PKCS1, chunk.bytes, length, &encryptedChunk, &encryptedLength)
                guard status == errSecSuccess else {
                    debugPrint("\(status)")
                    throw RSAError.decryptionFailed
                }
                encryptedData.append(encryptedChunk, count: encryptedLength)
                index += length
            }
        }
        
        return encryptedData
        
    }

    // RSA 복호화
    public func decrypt(encryptedData: Data) throws -> Data {
        guard let key = self.key else {
            throw RSAError.invalidMessage
        }
        
        let algorithm: SecKeyAlgorithm = .rsaEncryptionPKCS1
        guard SecKeyIsAlgorithmSupported(key, .decrypt, algorithm) else {
                print("Can't decrypt. Algorithm not supported.")
            throw RSAError.invalidMessage
        }
        
        var decryptedData = Data()
        let blockSize = SecKeyGetBlockSize(key)
        if #available(iOS 15, *) {
            let buffers = makeBuffers(fromData: encryptedData, bufferSize: blockSize)
            
            for buffer in buffers {
                var encryptionError: Unmanaged<CFError>?
                guard let decryptedBuffer = SecKeyCreateDecryptedData(key,
                                                                      algorithm,
                                                                      buffer as CFData, &encryptionError) as Data? else {
                    throw encryptionError!.takeRetainedValue() as Error
                }
                
                decryptedData.append(decryptedBuffer)
            }
            
        } else {
            //            let blockSize = keySize / 8
            var index = 0
            while index < encryptedData.count {
                let length = Swift.min(blockSize, encryptedData.count - index)
                let chunk = encryptedData.subdata(in: index..<index+length)
                var decryptedChunk = [UInt8](repeating: 0, count: blockSize)
                var decryptedLength = decryptedChunk.count
                let status = SecKeyDecrypt(key, .PKCS1, chunk.bytes, length, &decryptedChunk, &decryptedLength)
                guard status == errSecSuccess else {
                    debugPrint("\(status)")
                    throw RSAError.decryptionFailed
                }
                decryptedData.append(decryptedChunk, count: decryptedLength)
                index += length
            }
        }
        
        return decryptedData
    }
    
    
}

//MARK: - private functions
extension RSACipher {
    private func makeBuffers(fromData data: Data, bufferSize: Int) -> [Data] {
        guard data.count > bufferSize else {
            return [data]
        }
        
        var buffers: [Data] = []
        
        for i in 0..<bufferSize {
            let start = i * bufferSize
            if start > data.count {
                break
            }
            
            let lengthOffset = start + bufferSize
            let length = lengthOffset < data.count ? bufferSize : data.count - start
            
            let bufferRange = Range<Data.Index>(NSMakeRange(start, length))!
            buffers.append(data.subdata(in: bufferRange))
        }
        
        return buffers
    }
}
