import SwiftUI
import IndexedScrollView

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Contact")
                .font(.system(size: 20, weight: .bold))
            
            IndexedScrollView(dataSource: ChosungContactsBook(contacts: Contact.mockContacts),
                              header: { key in ContactHeader(key: key)},
                              cell: { contact in ContactCell(contact: contact) },
                              indexBarItemType: .default(IndexedScrollViewTextDesign(font: .system(size: 15)))
            )
        }
        .padding([.leading, .trailing], 10)
    }
}

struct ContactHeader: View {
    let key: String
    
    var body: some View {
        HStack {
            Text(key)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(Color.accentColor)
            Spacer()
        }
    }
}

struct ContactCell: View {
    let contact: Contact
    
    var body: some View {
        HStack {
            Text(contact.name)
            Spacer()
            Text(contact.phoneNumber)
        }
        .padding(10)
    }
}

