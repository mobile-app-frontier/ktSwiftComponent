# Version

지원하는 버전 포멧:​ major.minor.patch(-preRelease)
https:​//semver.org/
ex. 1.6.1, 2.10.4-beta

``` swift
public struct Version: Comparable 
```

주의\!: 버전 비교 시에는 preRelease 는 확인하지 않는다.
지원하지 않는 포멧인 경우 FormatException 을 발생시킨다.

## Inheritance

`Comparable`

## Initializers

### `init(_:)`

``` swift
public init(_ version: String) 
```

### `init(major:minor:patch:preRelease:)`

``` swift
public init(major: Int, minor: Int, patch: Int, preRelease: String?) 
```

## Properties

### `major`

``` swift
public let major: Int
```

### `minor`

``` swift
public let minor: Int
```

### `patch`

``` swift
public let patch: Int
```

### `preRelease`

``` swift
public let preRelease: String?
```

## Methods

### `getAppVersion()`

``` swift
public static func getAppVersion() -> Version 
```

## Operators

### `==`

``` swift
public static func == (lhs: Version, rhs: Version) -> Bool 
```

### `<`

``` swift
public static func < (lhs: Version, rhs: Version) -> Bool 
```

### `<=`

``` swift
public static func <= (lhs: Version, rhs: Version) -> Bool 
```

### `>`

``` swift
public static func > (lhs: Version, rhs: Version) -> Bool 
```

### `>=`

``` swift
public static func >= (lhs: Version, rhs: Version) -> Bool 
```
