//
//  DataSource.swift
//  ExampleIndexedScrollView
//
//  Created by 이소정 on 2023/08/24.
//

import Foundation
import OrderedCollections

typealias ChosungContactsBook = OrderedDictionary<String, [Contact]>

extension ChosungContactsBook {
    init(contacts: [Contact]) {
        let sectionDictionary: OrderedDictionary<String, [Contact]> = {
            return OrderedDictionary<String, [Contact]>(grouping: contacts, by: {
                $0.name.firstJamo
            })
        }()
        self = sectionDictionary
    }
}

struct Contact: Hashable, Identifiable {
    let id: UUID = UUID()
    let name: String
    let phoneNumber: String
}

// Contact + MockData
extension Contact {
    static let mockContacts = [
        Contact(name: "가나", phoneNumber: "010-1111-1111"),
        Contact(name: "가나다", phoneNumber: "010-2222-2222"),
        Contact(name: "갸", phoneNumber: "010-3333-3333"),
        Contact(name: "거", phoneNumber: "010-4444-4444"),
        Contact(name: "거너더", phoneNumber: "010-5555-5555"),
        Contact(name: "고노도", phoneNumber: "010-6666-6666"),
        Contact(name: "나다", phoneNumber: "010-7777-7777"),
        Contact(name: "나다라", phoneNumber: "010-8888-8888"),
        Contact(name: "나다라마", phoneNumber: "010-9999-9999"),
        Contact(name: "다", phoneNumber: "010-1111-1112"),
        Contact(name: "다라", phoneNumber: "010-2222-2223"),
        Contact(name: "다라마", phoneNumber: "010-3333-3334"),
        Contact(name: "댜", phoneNumber: "010-4444-4445"),
        Contact(name: "도로모", phoneNumber: "010-5555-5556"),
        Contact(name: "댜랴먀", phoneNumber: "010-6666-6667"),
        Contact(name: "디리미", phoneNumber: "010-7777-7778"),
        Contact(name: "라마바", phoneNumber: "010-8888-8889"),
        Contact(name: "마", phoneNumber: "010-8888-8889"),
        Contact(name: "먀", phoneNumber: "010-8888-8889"),
        Contact(name: "먀뱌샤", phoneNumber: "010-8888-8889"),
        Contact(name: "모보소", phoneNumber: "010-8888-8889"),
        Contact(name: "미비시", phoneNumber: "010-8888-8889")

    ]
}
