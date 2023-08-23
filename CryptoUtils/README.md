# CryptoUtils

Module description

- [Example](#example)
- [structure](#structure)

## Example

``` Swift
// Code block
struct SampleView: View {
    var body = {
        VStack {

        }
    }
}
```

## Structure

| name | param | return | Description |
| :--- | :---: | ---: | --- |
| getIndex | Void | Int | get index |
| setIndex | Int | Void | set index |


Link [Link](https://google.com)

> **NOTE:** \
hello note 


## [MORE](/Documentation/CryptoUtils/Home.md)



## AES

## RSA
----
현재는 pem format만 제공함.

###encrypt

```swift

let secKey = try CipherKeyUtils.wrapPublicKey(publicKeyString: pubKey)
        
let cipher = RSACipher(publicKey: secKey)

cipher.encrpyt(data: data)        

```

