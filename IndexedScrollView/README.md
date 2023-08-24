# IndexedScrollView

Module description

- [Example](#example)
- [More](#more)

## Example
``` Swift
// Code block
typealias ChosungContactsBook = OrderedDictionary<String, [Contact]>

struct SampleView: View {
    var body: some View {
        IndexedScrollView(
            dataSource: ChosungContactBook.mock, // data
            header: { key in Text(key) },
            cell: { contact in Text(contact.name) })}
}
```

## [MORE](/Documentation/IndexedScrollView/Home.md)
