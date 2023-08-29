//
//  InfiniteScrollModifier.swift
//  
//
//  Created by kimrlyunah on 2023/04/20.
//

import SwiftUI

/// View에 modifier 형태로 붙여서 사용할 수 있는 Pull to refresh 및 Infinite scroll 제공.
///
/// 스크롤 높이에 따라 Pull To Refresh 또는 Infinite Scrolling을 실행한다.
///
/// ### Notes: ###
/// - bloc: Pull To Refresh, Infinite Scroll 상태 관리.
/// - screenTopEdge: 스크롤 뷰 시작 지점 좌표.
/// - prevOffset: Pull To Refresh 호출 결정에 사용되는 요소.
/// - refreshingChecked: 스크롤을 한번 당겨서 Pull To Refresh가 호출되었는지 여부.
public struct InfiniteScrollModifier: ViewModifier {
    
    /// 스크롤 상태 관리
    @StateObject
    private var bloc: InfiniteScrollerBloc = InfiniteScrollerBloc()
    
    @State
    private var screenTopEdge: CGFloat = 0
    
    @State
    private var prevOffset: CGFloat = 0
    
    @State
    private var refreshingChecked: Bool = false
    
    private let scrollGeometry: String = "scroll"
    
    /// Pull To Refresh 및 Infinite Scrolling 정의.
    public let delegate: InfiniteScrollDelegate
    
    /// delegate에 사용자가 정의한 동작을 바탕으로 pull to refresh 및 infinite scrolling을 트리거할 수 있는 modifier를 생성.
    ///
    /// - 사용자가 스크롤을 일정 높이 이상으로 잡아당기면 pull to refresh 콜백이 호출됩니다.
    /// - 스크롤이 화면 하단에 도달했을 때, 사용자가 스크롤을 계속 내리면 infinite scroll 콜백이 호출됩니다.
    public init(delegate: InfiniteScrollDelegate) {
        self.delegate = delegate
    }
    
    /// modifier를 호출한 View가 pull to refresh 및 infinite scroll를 트리거 할 수 있게 만든다.
    public func body(content: Content) -> some View {
        GeometryReader {  screenProxy in
            ScrollView {
                VStack(spacing: 0) {
                    VStack {
                        if refreshingChecked {
                            refreshProgressView()
                        }
                    }
                    .background(GeometryReader { proxy in
                        Color.clear
                            .preference(
                                key: PullToRefreshKey.self,
                                value: proxy.frame(in: .named(scrollGeometry)).origin.y
                            )
                    })
                    .onPreferenceChange(PullToRefreshKey.self) {
                        if !refreshingChecked && prevOffset > $0 && $0 > screenTopEdge && bloc.canRefresh {
                            refreshingChecked = true
                            guard let pullToRefresh = delegate.pullToRefresh else {
                                return
                            }
                            Task {
                                bloc.setRefresh()
                                await pullToRefresh()
                                bloc.setIdle()
                            }
                        }
                        prevOffset = $0
                        if $0 == 0 {
                            refreshingChecked = false
                        }
                    }
                    
                    content
                        .background (
                            GeometryReader { proxy in
                                Color.clear
                                    .preference(
                                        key: ScrollCurrentOffsetKey.self,
                                        value: ScrollSet(
                                            scrollTop: proxy.frame(in: .global).maxY,
                                            scrollHeight: proxy.size.height
                                        )
                                    )
                            }
                        )
                    if bloc.isOnGoing {
                        infiniteProgressView()
                    }
                }
            }
            .onAppear {
                /// 스크롤 뷰 시작 지점 좌표
                screenTopEdge = screenProxy.frame(in: .global).origin.y
            }
            .coordinateSpace(name: scrollGeometry)
            .onPreferenceChange(ScrollCurrentOffsetKey.self) { scrollProxy in
                
                guard let fetchMore = delegate.fetchMore else {
                    return
                }
                
                /// scrollTop: (content의 총 높이 - 이미 스크롤 되어서 보이지 않는 영역의 높이)
                let scrollTop = scrollProxy.scrollTop
                
                /// scrollHeight: content의 총 높이
                let scrollHeight = scrollProxy.scrollHeight
                
                /// screenHeight: 사용자에게 보여지는 스크린 높이
                let screenHeight = screenProxy.size.height
                
                /// content의 총 높이가 스크린 높이보다 작거나 같으면 infinite scroll을 호출하지 않는다.
                if  scrollHeight <= screenHeight {
                    return
                }
                
                if !bloc.isLoading && scrollTop <= screenHeight {
                    Task {
                        bloc.setOnGoing()
                        await fetchMore()
                        bloc.setIdle()
                    }
                }
            }
        }
    }
}
