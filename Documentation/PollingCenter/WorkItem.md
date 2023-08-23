# WorkItem

``` swift
public protocol WorkItem 
```

## Requirements

### Category

``` swift
associatedtype Category: WorkItemCategory
```

### category

``` swift
var category: Category 
```

### task

``` swift
var task: [PollingTask] 
```

### type

``` swift
var type: WorkItemType 
```
