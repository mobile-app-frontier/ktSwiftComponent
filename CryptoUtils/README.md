# CryptoUtils

A description of this package.


## AES

## RSA
----
현재는 pem format만 제공함.

###encrypt

///```swift

let secKey = try CipherKeyUtils.wrapPublicKey(publicKeyString: pubKey)
        
let cipher = RSACipher(publicKey: secKey)

cipher.encrpyt(data: data)        
///```
