# request(\_:method:header:param:encoding:cancelToken:requestInterceptor:responseInterceptor:)

``` swift
public func request(_ url:String,
                        method: NetworkMethod,
                        header: [String: String] = [:],
                        param: [String: Any] = [:],
                        encoding: NetworkRequestEncoding = .url,
                        cancelToken: NetworkCancelToken? = nil,
                        requestInterceptor: NetworkRequestInterceptor? = nil,
                        responseInterceptor: NetworkResponseInterceptor? = nil
    )
```
