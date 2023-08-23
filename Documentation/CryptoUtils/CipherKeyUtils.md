# CipherKeyUtils

``` swift
public struct CipherKeyUtils 
```

## Methods

### `generateSymmetricKey(keySize:)`

``` swift
public static func generateSymmetricKey(keySize: Int) -> SymmetricKey
```

### `wrapSymmetricKey(data:)`

``` swift
public static func wrapSymmetricKey(data: Data) -> SymmetricKey 
```

### `generateRSAKey(keyLength:)`

``` swift
public static func generateRSAKey(keyLength: Int) throws -> SecKey 
```

### `wrapPublicKey(publicKeyString:)`

``` swift
public static func wrapPublicKey(publicKeyString: String) throws -> SecKey 
```

### `wrapPublicKey(publicKeyData:)`

``` swift
public static func wrapPublicKey(publicKeyData: Data) throws -> SecKey 
```
