//
//  IndexedBloc.swift
//  GeniePhone
//
//  Created by 이소정 on 2023/03/27.
//

import Foundation

internal extension IndexedScrollView {
     final class IndexedScrollBloc: ObservableObject {
        @Published
        var state = IndexedScrollState()
        
        func changeId(_ id: Key) {
            state = IndexedScrollState(id: id, opacity: true)
        }
        
        func hide() {
            state = IndexedScrollState(id: state.id, opacity: false)
        }
    }
}

