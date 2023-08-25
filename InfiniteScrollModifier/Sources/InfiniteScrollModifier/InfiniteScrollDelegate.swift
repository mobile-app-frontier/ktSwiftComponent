//
//  InfiniteScrollDelegate.swift
//  
//
//  Created by kimrlyunah on 2023/04/18.
//

import Foundation
import SwiftUI

/// InfiniteScrollModifier 생성 시에 속성을 정의한다.
public struct InfiniteScrollDelegate {
    /// 상단 새로고침 시 수행할 콜백을 등록한다.
    /// nil이면 pull to refresh가 호출되지 않는다.
    var pullToRefresh: (() async -> Void)?
    /// 하단 불러오기 시 수행할 콜백을 등록한다.
    /// nil이면 infinite scroll이 호출되지 않는다.
    var fetchMore: (() async -> Void)?
    /// 상단 새로고침 시 보여질 View를 받는다.
    ///  nil이면 DefaultProgressView가 표출된다.
    var refreshProgressView: (() -> any View)?
    /// 하단 불러오기 시 보여질 View를 받는다.
    /// nil이면 DefaultProgressView가 표출된다.
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
