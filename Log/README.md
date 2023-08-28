# Log

Log 모듈.

XCode에서 Filtering 할 수 있는 옵션이 있음.

사용 예시 참고.
- [Example](#example)

## Example
### 기본 사용법
``` Swift
Log.log("============ Basic Usecase Test ===========", level: .info)
let option = LogFilter()
Log.initialize(option: option)
Log.e("My play ground error message!!!!")
Log.i("My play ground message!!!!")
Log.d("My play ground debug message!!!!")
```
#### Output
> [2023-08-28 15:06:52] (I) [MyPlayground:20] test(): ============ FileName filter initialize Test ===========   
[2023-08-28 15:06:52] (E) [MyPlayground:23] test(): My play ground error message!!!!   
[2023-08-28 15:06:52] (I) [MyPlayground:24] test(): My play ground message!!!!   
[2023-08-28 15:06:52] (D) [MyPlayground:25] test(): My play ground debug message!!!!

### initialize Filter 사용 예시. 필터링 원하는 파일 이름 list로 넘기면 됨.
```Swift
Log.log("============ FileName filter initialize ===========", level: .info)
let option2 = LogFilter(fileNames: [""])
Log.initialize(option: option2)
Log.e("My play ground error message!!!!")
Log.i("My play ground message!!!!")
Log.d("My play ground debug message!!!!")
```
#### Output => 파일 이름이 빈게 없기 때문에 아무것도 안 찍힘.
> [2023-08-28 15:06:52] (I) [MyPlayground:27] test(): ============ FileName filter initialize Test2 ===========

### 전체 필터가 아닌 함수 필터 적용했을 때 테스트
```Swift
Log.log("============ function filter Test ===========", level: .info, customFilter: LogFilter())
let option3 = LogFilter(isOSLogOn: true, level: .info)
Log.e("My play ground message!!!!", customFilter: option3)
```
#### Output
> [2023-08-28 15:06:52] (I) [MyPlayground:34] test(): ============ function filter Test ===========   
[2023-08-28 15:06:52] (E) [MyPlayground:36] test(): My play ground message!!!!


### Log level filter 테스트
```Swift
Log.log("============ Level Filter Test ===========", level: .info, customFilter: LogFilter())
let option4 = LogFilter(isOSLogOn: true, level: .debug)
Log.initialize(option: option4)
Log.e("My play ground error message!!!!")
Log.i("My play ground message!!!!")
Log.d("My play ground debug message!!!!")
```
#### Output
> [2023-08-28 15:06:52] (I) [MyPlayground:39] test(): ============ level option Test ===========   
[2023-08-28 15:06:52] (E) [MyPlayground:42] test(): My play ground error message!!!!    
[2023-08-28 15:06:52] (I) [MyPlayground:43] test(): My play ground message!!!!   
[2023-08-28 15:06:52] (D) [MyPlayground:44] test(): My play ground debug message!!!!

## [MORE](/Documentation/Log/Home.md)
