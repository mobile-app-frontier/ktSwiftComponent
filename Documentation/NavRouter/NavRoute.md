# NavRoute

``` swift
public protocol NavRoute 
```

## Requirements

### Destination

``` swift
associatedtype Destination: View
```

### restorationIdentifier()

view ID로 mapping
popToView에서 사용함.

``` swift
func restorationIdentifier() -> String?
```

### view()

Creates and returns a view of assosiated type

``` swift
@ViewBuilder
    func view() -> Destination
```
