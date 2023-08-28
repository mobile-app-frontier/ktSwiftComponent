//
//  CryptorError.swift
//  GeniePhone
//
//  Created by kh Jang on 2023/04/11.
//

import Foundation

public enum CryptorError: Error {
    case keyGeneratingFail
    case saveKeyFailed
    case loadKeyFailed
    case updateKeyFailed
    case deleteKeyFailed
    case encryptionFailed
    case decryptionFailed
    case unableToCreateFileStream
    case unableToCreateEncryptionStream
}

public enum RSAError: Error {
    case invalidMessage
    case encryptionFailed
    case decryptionFailed
    case asn1ParsingFailed
    case invalidAsn1RootNode
    case invalidAsn1Structure
    case keyCopyFailed(status: OSStatus)
    case keyAddFailed(status: OSStatus)
    case tagEncodingFailed
    case keyCreateFailed(error: CFError?)
    case failedPublicKeyEncoding
    case pemDoesNotContainKey
    case failedToCreatePubKey
    case emptyPrivateKey
}
