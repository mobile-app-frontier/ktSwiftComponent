//
//  InfiniteScrollDelegate.swift
//  
//
//  Created by kimrlyunah on 2023/04/18.
//

import Foundation
import SwiftUI

/// InfiniteScrollModifier에 전달할 콜백 및 뷰, 사용 여부를 결정해준다.
public struct InfiniteScrollDelegate {
    
    /// pull to refresh 트리거 시 호출할 콜백을 등록한다.
    /// nil이면 pull to refresh가 호출되지 않는다.
    public var pullToRefresh: (() async -> Void)?

    /// infinite scroll 트리거 시 호출할 콜백을 등록한다.
    /// nil이면 infinite scroll이 호출되지 않는다.
    public var fetchMore: (() async -> Void)?
    
    /// pull to refresh 호출 시 보여질 View를 받는다.
    ///  nil이면 DefaultProgressView가 표출된다.
    public var refreshProgressView: (() -> any View)?
    
    /// infinite scroll 호출 시 보여질 View를 받는다.
    /// nil이면 DefaultProgressView가 표출된다.
    public var infiniteProgressView: (() -> any View)?
    
    /// pull to refresh 콜백, infinite scroll 콜백, pull to refresh 호출 후 출력할 프로그래스 뷰, infinite scroll 호출 후 출력할 프로그래스 뷰에 대한 사용자 설정을 받아서 modifier에 전달해준다.
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
