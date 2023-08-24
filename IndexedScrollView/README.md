# IndexedScrollView

`OrderedDictionary<Key, [Element]>` 를 데이터로 받아 Key 별로 스크롤이 가능한 View 제공

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
