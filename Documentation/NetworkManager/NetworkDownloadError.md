# NetworkDownloadError

``` swift
public enum NetworkDownloadError: NetworkError 
```

## Inheritance

[`NetworkError`](/Documentation/NetworkManager/NetworkError)

## Enumeration Cases

### `downloadStateError`

``` swift
case downloadStateError
```

### `failToMakeRequest`

``` swift
case failToMakeRequest(url: String)
```

### `serverError`

``` swift
case serverError(networkError: NetworkResponseError, rawError:Error)
```