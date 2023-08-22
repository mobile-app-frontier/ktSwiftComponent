# NetworkDownloadTask

``` swift
public protocol NetworkDownloadTask 
```

## Requirements

### downloadState

``` swift
var downloadState: Published<NetworkDownloadState>.Publisher 
```

### downloadProgress

``` swift
var downloadProgress: Published<Progress>.Publisher 
```

### prepareTask()

``` swift
func prepareTask()
```

### suspend()

``` swift
func suspend()
```

### resume()

``` swift
func resume()
```

### cancel()

``` swift
func cancel()
```
