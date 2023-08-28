import XCTest
//import CryptoKit
@testable import CryptoUtils

final class CryptoUtilsTests: XCTestCase {
    let original = "test string is here".data(using: .utf8)!
    // 1. aes 키 생성 후 encrypt decrypt
    func testAESKeyGeneration() throws {
//        let startTime = Date()
        
        let symmetricKey = CipherKeyUtils.generateSymmetricKey(keySize: 128)
        let cipher = AESCipher(symmetricKey: symmetricKey)

        let encrypted = try cipher.encrypt(originalData: original)
        let decrypted = try cipher.decrypt(encryptedData: encrypted)
        XCTAssertEqual(decrypted, original)
    }
    // 2. rsa 키 생성 후 encrypt decrypt
    func testRSAGeneration() throws {
//        let startTime = Date()
        let originalString = [String](repeating: "a", count: 128).joined(separator: "")
        let pureData = originalString.data(using: .utf8)!
        let privateKey = try CipherKeyUtils.generateRSAKey(keyLength: 2048)
        
        let cipher = RSACipher(privateKey: privateKey)
        
        
        let publicKey = try cipher.getPublicKey()
        // 암호화
        let encrypted = try cipher.encrypt(originalData: pureData)
        // 복호화
        let decrypted = try cipher.decrypt(encryptedData: encrypted)
        
        
        XCTAssertEqual(decrypted, pureData)
    }
    
    // 3. 텍스트 형태의 RSA key 테스트
    func testRsaEncrypt() throws {

        let pubKey = "-----BEGIN RSA PUBLIC KEY-----\nMIIBigKCAYEA4EsRV1YUnI+kW7WpknBo46uyfL7l79ZnEEycYkAzuimm7+nhxTxX\nFiaZuzk10G3Ki+Hdi4dGaTHKg+hoHnvjchHsv3TksNQZJn+LznOg5lvSAs3EIDFU\nW6PNv7TJ/jtFc4xgkLO+pKPdGwfQqdB+oNT6KTya0hwPyxiXfDGboCBMtHo8IrFI\nJMRUCzQy72enHQOsTAPfN3RX14CUQr4z/NF/bA/gNUKmjmL0HP0eCibZhhcplSDK\n9YIukyImS6kv1EU2o7gv9Pe5sjdq9uqJJ0iUMNtUrWPu/2mpXLpZ96pmG0frcDby\nqb0KDnHJD4MNErqAFfBxxYF3/UtZVIRLKPcXp+gL2kil1Khdg9wmjLBJsxd0btT8\nuJjOwgnuzbK8cPVbZTe4P5AEusu8CuHNwRkZ6aU7Ud57pzoJ/eL+zBsf6qnFVF7g\nTiI2wwS1S4OcMY4RqtRy8QKS5a5wGbdN8EkakFY6cBx4LVpMNzfkTfxLLf2xlCgc\nZcmhYuaS0HpHAgMBAAE=\n-----END RSA PUBLIC KEY-----"
        
        
        let secKey = try CipherKeyUtils.wrapPublicKey(publicKeyString: pubKey)
        
        let cipher = RSACipher(publicKey: secKey)
        let data = try cipher.encrypt(originalData: "hello world".data(using: .utf8)!)
        
        debugPrint("test")
    }
    
    
    // 4. 텍스트 형태로 만든 AES 키 테스트
    func testAESEncryption() throws {
        let keyData = "findKey1findKey1".data(using: .utf8)!
        
        debugPrint("start!!\(keyData.count)")
        let symmetricKey = CipherKeyUtils.wrapSymmetricKey(data: keyData)
        let cipher: AESCipher = AESCipher(symmetricKey: symmetricKey)
        // 암호화
        let encrypted = try original.encrypt(cipher: cipher)
        // 복호화
        let decrypted = try encrypted.decrypt(cipher: cipher)
        XCTAssertEqual(decrypted, original)
    }
}
