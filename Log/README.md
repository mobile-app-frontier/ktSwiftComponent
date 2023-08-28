# Log

Module description

- [Example](#example)
- [structure](#structure)

## Example

``` Swift
Log.log("============ FileName filter initialize Test ===========", level: .info)
let option = LogFilter(fileNames: ["MyPlayground"])
Log.initialize(option: option)
Log.e("My play ground error message!!!!")
Log.i("My play ground message!!!!")
Log.d("My play ground debug message!!!!")

Log.log("============ FileName filter initialize Test2 ===========", level: .info)
let option2 = LogFilter(fileNames: [""])
Log.initialize(option: option2)
Log.e("My play ground error message!!!!")
Log.i("My play ground message!!!!")
Log.d("My play ground debug message!!!!")

Log.log("============ function filter Test ===========", level: .info, customFilter: LogFilter())
let option3 = LogFilter(isOSLogOn: true, level: .info)
Log.e("My play ground message!!!!", customFilter: option3)


Log.log("============ level option Test ===========", level: .info, customFilter: LogFilter())
let option4 = LogFilter(isOSLogOn: true, level: .debug)
Log.initialize(option: option4)
Log.e("My play ground error message!!!!")
Log.i("My play ground message!!!!")
Log.d("My play ground debug message!!!!")

// Output
[2023-08-28 15:06:52] (I) [MyPlayground:20] test(): ============ FileName filter initialize Test ===========
[2023-08-28 15:06:52] (E) [MyPlayground:23] test(): My play ground error message!!!!
[2023-08-28 15:06:52] (I) [MyPlayground:24] test(): My play ground message!!!!
[2023-08-28 15:06:52] (D) [MyPlayground:25] test(): My play ground debug message!!!!
[2023-08-28 15:06:52] (I) [MyPlayground:27] test(): ============ FileName filter initialize Test2 ===========
[2023-08-28 15:06:52] (I) [MyPlayground:34] test(): ============ function filter Test ===========
[2023-08-28 15:06:52] (E) [MyPlayground:36] test(): My play ground message!!!!
[2023-08-28 15:06:52] (I) [MyPlayground:39] test(): ============ level option Test ===========
[2023-08-28 15:06:52] (E) [MyPlayground:42] test(): My play ground error message!!!!
[2023-08-28 15:06:52] (I) [MyPlayground:43] test(): My play ground message!!!!
[2023-08-28 15:06:52] (D) [MyPlayground:44] test(): My play ground debug message!!!!
```

## Structure

| name | param | return | Description |
| :--- | :---: | ---: | --- |
| getIndex | Void | Int | get index |
| setIndex | Int | Void | set index |


Link [Link](https://google.com)

> **NOTE:** \
hello note 


## [MORE](/Documentation/Log/Home.md)
