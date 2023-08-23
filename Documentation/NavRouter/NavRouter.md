# NavRouter

``` swift
public protocol NavRouter: ObservableObject 
```

## Inheritance

`ObservableObject`

## Default Implementations

### `start()`

``` swift
func start() 
```

### `present(_:animated:isModal:)`

``` swift
func present(_ route: Route, animated: Bool = true, isModal: Bool) 
```

### `presentWithOptions(_:animated:options:)`

``` swift
func presentWithOptions(_ route: Route, animated: Bool = true, options:NavRoutePresentOptions) 
```

### `dismiss(animated:)`

``` swift
func dismiss(animated: Bool = true) 
```

### `push(_:animated:)`

``` swift
func push(_ route: Route, animated: Bool = true) 
```

### `pop(animated:)`

``` swift
func pop(animated: Bool = true) 
```

### `popToRoot(animated:)`

``` swift
func popToRoot(animated: Bool = true) 
```

### `popToView(restorationIdentifier:animated:)`

``` swift
func popToView(restorationIdentifier: String?, animated: Bool = true) 
```

### `replace(_:animated:)`

``` swift
func replace(_ route: Route, animated: Bool = true) 
```

### `didRouteNav(action:)`

``` swift
func didRouteNav(action: NavRouterAction) 
```

## Requirements

### Route

``` swift
associatedtype Route: NavRoute
```

### getNavigationController()

root navigation controller

``` swift
func getNavigationController() -> UINavigationController
```

### getStartingRoute()

starting route
start호출시 해당 route를 push한다.

``` swift
func getStartingRoute() -> Route?
```

### start()

getStartingRoute()를push해주는 기능.

``` swift
func start()
```

### present(\_:​animated:​isModal:​)

present modal or overlay screen

``` swift
func present(_ route: Route, animated: Bool , isModal: Bool)
```

### presentWithOptions(\_:​animated:​options:​)

``` swift
func presentWithOptions(_ route: Route, animated: Bool, options:NavRoutePresentOptions)
```

### dismiss(animated:​)

dismiss present screen
present로 올라온 view만 dismiss 가능
push 된 view는 그대로 있는다.

``` swift
func dismiss(animated: Bool )
```

### push(\_:​animated:​)

navigation stack에 route를 추가

``` swift
func push(_ route: Route, animated: Bool )
```

### pop(animated:​)

navigation stack에서 최 상위 vc를 제거

``` swift
func pop(animated: Bool )
```

### popToRoot(animated:​)

navigation stack에 root로 이동 (사이에 있는 vc는 제거)

``` swift
func popToRoot(animated: Bool )
```

### popToView(restorationIdentifier:​animated:​)

navigation stack에 restorationIdentifier가 같은 vc로 이동 (사이에 있는 vc는 제거)
지정한 restorationIdentifier 가 vc에 없을시 아무 동작 안함.

``` swift
func popToView(restorationIdentifier: String?, animated: Bool)
```

### replace(\_:​animated:​)

. navigation stack에 최 상위vc를 제거 하고 신규 vc를 추가

``` swift
func replace(_ route: Route, animated: Bool)
```

### didRouteNav(action:​)

NavRouter delegate

``` swift
func didRouteNav(action: NavRouterAction)
```
