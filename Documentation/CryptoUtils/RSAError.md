# RSAError

``` swift
public enum RSAError: Error 
```

## Inheritance

`Error`

## Enumeration Cases

### `invalidMessage`

``` swift
case invalidMessage
```

### `encryptionFailed`

``` swift
case encryptionFailed
```

### `decryptionFailed`

``` swift
case decryptionFailed
```

### `asn1ParsingFailed`

``` swift
case asn1ParsingFailed
```

### `invalidAsn1RootNode`

``` swift
case invalidAsn1RootNode
```

### `invalidAsn1Structure`

``` swift
case invalidAsn1Structure
```

### `keyCopyFailed`

``` swift
case keyCopyFailed(status: OSStatus)
```

### `keyAddFailed`

``` swift
case keyAddFailed(status: OSStatus)
```

### `tagEncodingFailed`

``` swift
case tagEncodingFailed
```

### `keyCreateFailed`

``` swift
case keyCreateFailed(error: CFError?)
```

### `failedPublicKeyEncoding`

``` swift
case failedPublicKeyEncoding
```

### `pemDoesNotContainKey`

``` swift
case pemDoesNotContainKey
```

### `failedToCreatePubKey`

``` swift
case failedToCreatePubKey
```

### `emptyPrivateKey`

``` swift
case emptyPrivateKey
```
