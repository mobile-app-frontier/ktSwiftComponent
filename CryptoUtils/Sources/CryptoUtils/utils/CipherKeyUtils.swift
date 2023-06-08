import SwiftUI
import CryptoKit
import Foundation

public struct CipherKeyUtils {
    
    public static func generateSymmetricKey(keySize: Int) -> SymmetricKey{
        return SymmetricKey(size: SymmetricKeySize(bitCount: keySize))
    }
    
    // keyData -> SymmetricKey
    public static func wrapSymmetricKey(data: Data) -> SymmetricKey {
        return SymmetricKey(data: data)
    }
    
    // RSA 키 생성 함수
    public static func generateRSAKey(keyLength: Int) throws -> SecKey {
        let attributes: [CFString: Any] = [
            kSecAttrKeyType: kSecAttrKeyTypeRSA,
            kSecAttrKeySizeInBits: keyLength
        ]
        
        var error: Unmanaged<CFError>?
        guard let privateKey = SecKeyCreateRandomKey(attributes as CFDictionary, &error) else {
            throw error!.takeRetainedValue() as Error
        }
        return privateKey
    }
    
    // keyData -> SecKey
    public static func wrapPublicKey(publicKeyString: String) throws -> SecKey {
        let wrapBase64Key = try publicKeyString.toBase64String()
        
        guard let data = Data(base64Encoded: wrapBase64Key, options: [.ignoreUnknownCharacters]) else {
            throw RSAError.failedPublicKeyEncoding
        }
        
        return try wrapPublicKey(publicKeyData: data)
    }
    
    public static func wrapPublicKey(publicKeyData: Data) throws -> SecKey {
        let stripedHeader = try stripKeyHeader(keyData: publicKeyData)
        let tag = UUID().uuidString

        return try addKey(stripedHeader, isPublic: true, tag: tag)
    }
}


//MARK: - RSA Key for pem format
extension CipherKeyUtils {
    private static func stripKeyHeader(keyData: Data) throws -> Data {
        let node: Asn1Parser.Node
        do {
            node = try Asn1Parser.parse(data: keyData)
        } catch {
            throw RSAError.asn1ParsingFailed
        }

        // Ensure the raw data is an ASN1 sequence
        guard case .sequence(let nodes) = node else {
            throw RSAError.invalidAsn1RootNode
        }

        // Detect whether the sequence only has integers, in which case it's a headerless key
        let onlyHasIntegers = nodes.filter { node -> Bool in
            if case .integer = node {
                return false
            }
            return true
        }.isEmpty

        // Headerless key
        if onlyHasIntegers {
            return keyData
        }

        // If last element of the sequence is a bit string, return its data
        if let last = nodes.last, case .bitString(let data) = last {
            return data
        }

        // If last element of the sequence is an octet string, return its data
        if let last = nodes.last, case .octetString(let data) = last {
            return data
        }

        // Unable to extract bit/octet string or raw integer sequence
        throw RSAError.invalidAsn1Structure
    }
    
    static private func addKey(_ keyData: Data, isPublic: Bool, tag: String) throws ->  SecKey {
        
        let keyData = keyData
        
        guard let tagData = tag.data(using: .utf8) else {
            throw RSAError.tagEncodingFailed
        }
        
        let keyClass = isPublic ? kSecAttrKeyClassPublic : kSecAttrKeyClassPrivate
        
        // On iOS 10+, we can use SecKeyCreateWithData without going through the keychain
        if #available(iOS 10.0, *), #available(watchOS 3.0, *), #available(tvOS 10.0, *) {
            
            let sizeInBits = keyData.count * 8
            let keyDict: [CFString: Any] = [
                kSecAttrKeyType: kSecAttrKeyTypeRSA,
                kSecAttrKeyClass: keyClass,
                kSecAttrKeySizeInBits: NSNumber(value: sizeInBits),
                kSecReturnPersistentRef: false
            ]
            
            var error: Unmanaged<CFError>?
            guard let key = SecKeyCreateWithData(keyData as CFData, keyDict as CFDictionary, &error) else {
                throw RSAError.keyCreateFailed(error: error?.takeRetainedValue())
            }
            return key
            
        // On iOS 9 and earlier, add a persistent version of the key to the system keychain
        } else {
            
            let persistKey = UnsafeMutablePointer<AnyObject?>(mutating: nil)
            
            let keyAddDict: [CFString: Any] = [
                kSecClass: kSecClassKey,
                kSecAttrApplicationTag: tagData,
                kSecAttrKeyType: kSecAttrKeyTypeRSA,
                kSecValueData: keyData,
                kSecAttrKeyClass: keyClass,
                kSecReturnPersistentRef: false,
                kSecAttrAccessible: kSecAttrAccessibleAfterFirstUnlock
            ]
            
            let addStatus = SecItemAdd(keyAddDict as CFDictionary, persistKey)
            guard addStatus == errSecSuccess || addStatus == errSecDuplicateItem else {
                throw RSAError.keyAddFailed(status: addStatus)
            }
            
            let keyCopyDict: [CFString: Any] = [
                kSecClass: kSecClassKey,
                kSecAttrApplicationTag: tagData,
                kSecAttrKeyType: kSecAttrKeyTypeRSA,
                kSecAttrKeyClass: keyClass,
                kSecAttrAccessible: kSecAttrAccessibleAfterFirstUnlock,
                kSecReturnRef: true,
            ]
            
            // Now fetch the SecKeyRef version of the key
            var keyRef: AnyObject?
            let copyStatus = SecItemCopyMatching(keyCopyDict as CFDictionary, &keyRef)
            
            guard let unwrappedKeyRef = keyRef else {
                throw RSAError.keyCopyFailed(status: copyStatus)
            }
            
            return unwrappedKeyRef as! SecKey // swiftlint:disable:this force_cast
        }
    }
    
}
