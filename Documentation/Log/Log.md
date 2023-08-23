# Log

``` swift
public class Log 
```

## Methods

### `initialize(option:)`

``` swift
public static func initialize(option: LogFilter) 
```

### `log(_:level:file:_:_:customFilter:)`

``` swift
public static func log<T>(
        _ message: T,
        level: LogLevel,
        file: String = #file,
        _ line: Int = #line,
        _ funcname: String = #function,
        customFilter: LogFilter? = nil
    ) 
```

### `i(_:file:_:_:customFilter:)`

``` swift
public static func i<T>(
        _ message: T,
        file: String = #file,
        _ line: Int = #line,
        _ funcname: String = #function,
        customFilter: LogFilter? = nil
    ) 
```

### `d(_:file:_:_:customFilter:)`

``` swift
public static func d<T>(
        _ message: T,
        file: String = #file,
        _ line: Int = #line,
        _ funcname: String = #function,
        customFilter: LogFilter? = nil) 
```

### `e(_:file:_:_:customFilter:)`

``` swift
public static func e<T>(
        _ message: T,
        file: String = #file,
        _ line: Int = #line,
        _ funcname: String = #function,
        customFilter: LogFilter? = nil) 
```
