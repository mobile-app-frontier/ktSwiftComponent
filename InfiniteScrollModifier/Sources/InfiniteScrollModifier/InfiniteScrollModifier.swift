//
//  InfiniteScrollModifier.swift
//  
//
//  Created by kimrlyunah on 2023/04/20.
//

import SwiftUI

/// View에 modifier 형태로 붙여서 사용할 수 있는 Pull to refresh 및 Infinite scrolling를 제공한다.
public struct InfiniteScrollModifier: ViewModifier {
    
    @StateObject
    var bloc: InfiniteScrollerBloc = InfiniteScrollerBloc()
    
    @State
    var screenTopEdge: CGFloat = 0
    
    @State
    var prevOffset: CGFloat = 0
    
    @State
    var refreshingChecked: Bool = false
    
    let scrollGeometry: String = "scroll"
    
    let delegate: InfiniteScrollDelegate
    
    /// modifier에 적용할 pull to refresh 및 infinite scroll 속성들을 설정한다.
    public init(delegate: InfiniteScrollDelegate) {
        self.delegate = delegate
    }
    
    /// 사용자가 스크롤을 일정 높이 이상으로 잡아당기면 pull to refresh 콜백이 호출된다.
    /// 스크롤이 화면 하단에 도달했을 때, 사용자가 스크롤을 계속 내리면 infinite scroll 콜백이 호출된다.
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
