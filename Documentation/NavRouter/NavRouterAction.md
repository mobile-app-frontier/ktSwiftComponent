# NavRouterAction

``` swift
public enum NavRouterAction
```

## Enumeration Cases

### `start`

``` swift
case start
```

### `pushRoute`

``` swift
case pushRoute(pushedRoute: any NavRoute)
```

### `popRoute`

``` swift
case popRoute
```

### `popToRoot`

``` swift
case popToRoot
```

### `popToView`

``` swift
case popToView(restorationIdentifier: String)
```

### `presentRouteModal`

``` swift
case presentRouteModal(presentedRoute: any NavRoute)
```

### `presentRouteSheet`

``` swift
case presentRouteSheet(presentedRoute: any NavRoute)
```

### `dimissRoute`

``` swift
case dimissRoute
```

### `replaceRoute`

``` swift
case replaceRoute(replaced: any NavRoute)
```
