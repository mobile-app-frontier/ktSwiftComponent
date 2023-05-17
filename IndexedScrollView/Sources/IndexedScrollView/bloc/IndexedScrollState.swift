//
//  IndexedState.swift
//  GeniePhone
//
//  Created by 이소정 on 2023/03/27.
//

import Foundation

extension IndexedScrollView {
    internal struct IndexedScrollState {
        let id: Key?
        let opacity: Bool
        
        init(id: Key? = nil, opacity: Bool = false) {
            self.id = id
            self.opacity = opacity
        }
    }
}

