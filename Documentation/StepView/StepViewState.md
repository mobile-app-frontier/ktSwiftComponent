# StepViewState

StepView 의 상태로
start :​ 시작상태
inprogress:​ 동작중인 상태
complete:​ 마지막 content 에서 다음 Content로 이동 요청시
exit :​ 처음 Content에서 이전 content로 이동 요청시

``` swift
public enum StepViewState 
```

## Enumeration Cases

### `start`

``` swift
case start
```

### `inprogress`

``` swift
case inprogress
```

### `complete`

``` swift
case complete
```

### `exit`

``` swift
case exit
```
