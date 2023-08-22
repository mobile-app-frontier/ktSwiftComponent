# AESCipher

``` swift
public struct AESCipher: Cipher 
```

## Inheritance

[`Cipher`](./Cipher)

## Initializers

### `init(symmetricKey:)`

``` swift
public init(symmetricKey: SymmetricKey) 
```

## Properties

### `key`

``` swift
public let key: SymmetricKey
```

## Methods

### `encrypt(originalData:)`

``` swift
public func encrypt(originalData: Data) throws -> Data 
```

### `decrypt(encryptedData:)`

``` swift
public func decrypt(encryptedData: Data) throws -> Data 
```
