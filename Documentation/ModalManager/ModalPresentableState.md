# ModalPresentableState

``` swift
public enum ModalPresentableState 
```

## Enumeration Cases

### `initState`

present / dismiss 작업을 수행하지 않는 상태

``` swift
case initState
```

### `onPresent`

someController.present 호출되어 작업이 수행되고 있는 상태

``` swift
case onPresent
```

### `onDismiss`

someController.dismiss 호출되어 작업이 수행되고 있는 상태

``` swift
case onDismiss
```
