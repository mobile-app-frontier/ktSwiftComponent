# RSACipher

``` swift
public struct RSACipher: Cipher 
```

## Inheritance

[`Cipher`](/Documentation/CryptoUtils/Cipher)

## Initializers

### `init(privateKey:publicKey:)`

``` swift
public init(privateKey: SecKey? = nil, publicKey: SecKey? = nil) 
```

## Properties

### `key`

``` swift
public let key: SecKey?
```

## Methods

### `getPublicKey()`

``` swift
public func getPublicKey() throws -> SecKey 
```

### `encrypt(originalData:)`

``` swift
public func encrypt(originalData: Data) throws -> Data 
```

### `decrypt(encryptedData:)`

``` swift
public func decrypt(encryptedData: Data) throws -> Data 
```
