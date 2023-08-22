# ModalManager

``` swift
@MainActor
public class ModalManager 
```

## Properties

### `instance`

``` swift
public static let instance: ModalManager 
```

## Methods

### `show(modalWindowStyle:modalContent:orderOption:)`

``` swift
func show(
        modalWindowStyle: ModalWindowStyle = ResizableModalWindowStyle(),
        modalContent: @escaping () -> some View,
        orderOption: ModalOrderOptions? = nil
    ) 
```

### `dismissModal()`

``` swift
func dismissModal() 
```
