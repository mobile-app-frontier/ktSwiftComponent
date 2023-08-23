# IndexedScrollView

Module description

- [Example](#example)
- [structure](#structure)

## Example

``` Swift
// Code block
struct SampleView: View {
    var body = {
        VStack {

        }
    }
}
```

## Structure

| name | param | return | Description |
| :--- | :---: | ---: | --- |
| getIndex | Void | Int | get index |
| setIndex | Int | Void | set index |


Link [Link](https://google.com)

> **NOTE:** \
hello note 


## [MORE](/Documentation/IndexedScrollView/Home.md)



## how to use
IndexedScrollView(dataSource: dataSource,
                  header: { key in
    HStack {
        Text("Section Header")
    }
},
                  cell: { contact in
    HStack {
        Text("Cell")
    }
})
