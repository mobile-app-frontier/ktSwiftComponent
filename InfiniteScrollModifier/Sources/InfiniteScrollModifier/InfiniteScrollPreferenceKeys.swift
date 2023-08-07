//
//  InfiniteScrollPreferenceKeys.swift
//  GeniePhone
//
//  Created by kimrlyunah on 2023/04/18.
//

import SwiftUI

// PullToRefresh를 요청하기 위해 필요
// PullToRefreshView가 위치하는 y좌표 값을 저장한다
struct PullToRefreshKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

// 더보기 요청을 위해 필요
struct ScrollCurrentOffsetKey: PreferenceKey {
    typealias Value = ScrollSet
    static var defaultValue = ScrollSet()
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value.scrollTop += nextValue().scrollTop
        value.scrollHeight += nextValue().scrollHeight
    }

}

struct ScrollSet : Equatable {
    var scrollTop: CGFloat = 0
    var scrollHeight: CGFloat = 0
    static func ==(lhs: ScrollSet, rhs: ScrollSet) -> Bool {
        return lhs.scrollTop == rhs.scrollTop && lhs.scrollHeight == rhs.scrollHeight
    }
}
