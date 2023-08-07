//
//  InfiniteScrollDelegate.swift
//  
//
//  Created by kimrlyunah on 2023/04/18.
//

import Foundation
import SwiftUI

/// InfiniteScrollModifier 생성 시에 속성을 정의합니다.
public struct InfiniteScrollDelegate {
    /// 상단 새로고침 시 수행할 콜백을 등록합니다. nil이면 새로고침이 실행되지 않습니다.
    var pullToRefresh: (() async -> Void)?
    /// 하단 불러오기 시 수행할 콜백을 등록합니다. nil이면 새로고침이 실행되지 않습니다.
    var fetchMore: (() async -> Void)?
    /// 상단 새로고침 시 보여질View를 받습니다. 없으면 DefaultProgressView가 표출됩니다.
    var refreshProgressView: (() -> any View)?
    /// 하단 불러오기 시 보여질 View를 받습니다. 없으면 DefaultProgressView가 표출됩니다.
    var infiniteProgressView: (() -> any View)?
    
    public init(
        pullToRefresh: ( () async-> Void)? = nil,
        fetchMore: ( () async-> Void)? = nil,
        refreshProgressView: (() -> any View)? = nil,
        infiniteProgressView: (() -> any View)? = nil
    ) {
        self.pullToRefresh = pullToRefresh
        self.fetchMore = fetchMore
        self.refreshProgressView = refreshProgressView
        self.infiniteProgressView = infiniteProgressView
    }
}
