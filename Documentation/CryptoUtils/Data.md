# Extensions on Data

## Properties

### `bytes`

``` swift
public var bytes: [UInt8] 
```

## Methods

### `checksum()`

``` swift
public func checksum() -> UInt16 
```

### `sha256()`

``` swift
public func sha256() -> Data 
```

### `decrypt(cipher:_:)`

``` swift
public func decrypt(cipher: any Cipher) throws -> Data 
```

### `encrypt(cipher:_:)`

``` swift
public func encrypt(cipher: any Cipher) throws -> Data 
```
