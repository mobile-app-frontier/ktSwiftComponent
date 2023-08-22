# StepController

``` swift
public class StepController<T>: ObservableObject 
```

## Inheritance

`ObservableObject`

## Initializers

### `init(contents:initialIndex:config:)`

``` swift
public init(contents: [StepContent<T>],
         initialIndex: Int,
         config: StepControllerOptions = StepControllerOptions.defaultOption ) 
```

## Properties

### `config`

``` swift
public let config: StepControllerOptions
```

### `index`

step controller's step index

``` swift
@Published
    public private(set) var index: Int
```

### `contents`

total process

``` swift
@Published
    public private(set) var contents: [StepContent<T>]
```

### `currentContent`

current content

``` swift
@Published
    public private(set) var currentContent: StepContent<T>
```

### `stepState`

stepView의 상태

``` swift
@Published
    public private(set) var stepState: StepViewState 
```

## Methods

### `appendContent(content:)`

신규 타입의 content를 리스트에 추가

``` swift
func appendContent(content: StepContent<T>) 
```

#### Parameters

  - content: 추가 할 새로운 content

### `nextContent()`

다음 content 노출

``` swift
func nextContent() 
```

### `prevContent()`

이전 content를 노출

``` swift
func prevContent() 
```

### `willStepSwitchProcess(perform:)`

다음 스탭으로 가기 전 상태를 callbak

``` swift
func willStepSwitchProcess(perform: @escaping (StepContent<T>, StepContent<T>) -> Void) -> StepController 
```

#### Parameters

  - perform: 현재 상태와 다음 상태를 받을 수 있다
