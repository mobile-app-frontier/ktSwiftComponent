//
//  InfiniteScrollerBloc+ScrollStatus.swift
//  
//
//  Created by kimrlyunah on 2023/04/19.
//

import Foundation

extension InfiniteScrollerBloc {
    enum ScrollStatus {
        case idle
        case onGoing
        case refreshing
    }
}
