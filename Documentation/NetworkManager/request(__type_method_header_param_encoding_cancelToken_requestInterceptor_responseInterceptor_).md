# request(\_:type:method:header:param:encoding:cancelToken:requestInterceptor:responseInterceptor:)

``` swift
public func request<T> (_ url:String,
                            type: T.Type,
                            method: NetworkMethod,
                            header: [String: String] = [:],
                            param: [String: Any] = [:],
                            encoding: NetworkRequestEncoding = .url,
                            cancelToken: NetworkCancelToken? = nil,
                            requestInterceptor: NetworkRequestInterceptor? = nil,
                            responseInterceptor: NetworkResponseInterceptor? = nil
    )
```
