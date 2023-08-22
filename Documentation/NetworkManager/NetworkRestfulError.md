# NetworkRestfulError

``` swift
public enum NetworkRestfulError: NetworkError 
```

## Inheritance

[`NetworkError`](./NetworkError)

## Enumeration Cases

### `parsingError`

parsing error

``` swift
case parsingError(rawError: Error)
```

### `timeoutError`

``` swift
case timeoutError(rawError: Error, url: String)
```

### `serverError`

network error

``` swift
case serverError(networkError: NetworkResponseError, rawError: Error?)
```

### `canceled`

``` swift
case canceled(url:String)
```

### `invalidCancelerToken`

``` swift
case invalidCancelerToken
```
