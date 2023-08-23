# Cipher

encrypt, decrypt protocol

``` swift
public protocol Cipher 
```

## Requirements

### KeyType

cipher key

``` swift
associatedtype KeyType
```

### key

``` swift
var key: KeyType 
```

### encrypt(originalData:​)

encrypt data

``` swift
func encrypt(originalData: Data) throws -> Data
```

### decrypt(encryptedData:​)

decrypt data

``` swift
func decrypt(encryptedData: Data) throws -> Data
```
