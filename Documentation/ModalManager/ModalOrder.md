# ModalOrder

``` swift
public protocol ModalOrder 
```

## Requirements

### add(controller:​orderOptions:​)

``` swift
func add(
        controller: ModalController,
        orderOptions: ModalOrderOptions?
    )
```

### remove()

``` swift
func remove()
```

### topModal()

``` swift
func topModal() -> ModalController?
```

### modals()

``` swift
func modals() -> Int
```
