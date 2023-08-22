# WebSocketService

``` swift
public protocol WebSocketService 
```

## Requirements

### receiveData

``` swift
var receiveData: Published<Data>.Publisher 
```

### connectState

``` swift
var connectState: Published<NetworkWebSocketConnectState>.Publisher 
```

### connect(url:​)

``` swift
func connect(url: URL)
```

### send(data:​)

``` swift
func send(data: Data)
```
