# Types

  - [NetworkDownloadState](./NetworkDownloadState):
    downdload state
  - [NetworkRestfulError](./NetworkRestfulError)
  - [NetworkDownloadError](./NetworkDownloadError)
  - [NetworkMethod](./NetworkMethod):
    Network method
  - [NetworkRequestEncoding](./NetworkRequestEncoding)
  - [NetworkWebSocketConnectState](./NetworkWebSocketConnectState)
  - [NetworkManager](./NetworkManager)
  - [NetworkResponseError](./NetworkResponseError):
    normal error code
    1xx : info
    2xx : success
    3xx : redirection
    4xx: client error
    5xx: server error
  - [NetworkRequest](./NetworkRequest)
  - [NetworkCancelToken](./NetworkCancelToken)

# Protocols

  - [NetworkResponseInterceptor](./NetworkResponseInterceptor)
  - [NetworkDownloadTask](./NetworkDownloadTask)
  - [WebSocketService](./WebSocketService)
  - [NetworkError](./NetworkError)
  - [AlamofireNetworkRequestInterceptor](./AlamofireNetworkRequestInterceptor)

# Global Functions

  - [request(\_:​type:​method:​header:​param:​encoding:​cancelToken:​requestInterceptor:​responseInterceptor:​)](./request\(__type_method_header_param_encoding_cancelToken_requestInterceptor_responseInterceptor_\))
  - [request(\_:​method:​header:​param:​encoding:​cancelToken:​requestInterceptor:​responseInterceptor:​)](./request\(__method_header_param_encoding_cancelToken_requestInterceptor_responseInterceptor_\))
  - [cancelRequest(cancelToken:​)](./cancelRequest\(cancelToken_\))
