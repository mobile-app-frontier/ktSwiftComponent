//
//  IndexedScrollView.swift
//  GeniePhone
//
//  Created by 이소정 on 2023/03/27.
//

import Foundation
import SwiftUI
import OrderedCollections

/// `OrderedDictionary<Key, [Element]>` Type 의 Data 를 통해 Key 별로 categorize 되어 Scroll 될 수 있는 View 를 제공
public struct IndexedScrollView<Key, Element, SectionHeader, Cell>: View
where Key: Hashable,
      Key: Comparable,
      Element: Hashable,
      SectionHeader: View,
      Cell: View
{
    /// Key 가 StringProtocol 을 따를 때 사용할 수 있는 initialzer
    /// - Parameters:
    ///   - dataSource: View 를 그릴 기본 데이터
    ///   - header: Header ViewBuilder. parameter 로 Key 를 받음.
    ///   - cell: Cell ViewBuilder, parameter 로 Element 를 받음.
    ///   - indexBarItemType: 선택 파라미터. 입력하지 않으면 오른쪽 스크롤 영역의 Item 을 기본 style 로 정함.
    ///   - sectionPreviewType: 선택 파라미터. 입력하지 않으면 기본 Style 의 Section Preview 를 정함.
    ///   - scrollAnimationDuration: 선택 파라미터. 입력하지 않으면 0.2 sec duration 으로 스크롤
    public init(dataSource: OrderedDictionary<Key, [Element]>,
                @ViewBuilder header: @escaping (Key) -> SectionHeader,
                @ViewBuilder cell: @escaping (Element) -> Cell,
                indexBarItemType: IndexBarItemType = .default(nil),
                sectionPreviewType: SectionPreviewType = .default(nil),
                scrollAnimationDuration: Double = 0.2
    ) where Key: StringProtocol {
        self.dataSource = dataSource
        self.header = header
        self.cell = cell
        self.indexBarItem = indexBarItemType.content
        self.sectionPreview = sectionPreviewType.content
        self.scrollAnimationDuration = scrollAnimationDuration
        self.indexBarItemDefaultDesign = indexBarItemType.design
        self.sectionPreviewDefaultDesign = sectionPreviewType.design
    }
    
    /// 기본 initializer
    /// - Parameters:
    ///   - dataSource: View 를 그릴 기본 데이터
    ///   - header: Header ViewBuilder. parameter 로 Key 를 받음.
    ///   - cell: Cell ViewBuilder, parameter 로 Element 를 받음.
    ///   - indexBarItem: 오른쪽 스크롤 바의 Item 디자인. 필수 파라미터.
    ///   - sectionPreview:  선택 파라미터. 입력하지 않으면 Section Preview 는 보여지지 않음.
    ///   - scrollAnimationDuration: 선택 파라미터. 입력하지 않으면 0.2 sec duration 으로 스크롤
    public init(dataSource: OrderedDictionary<Key, [Element]>,
                @ViewBuilder header: @escaping (Key) -> SectionHeader,
                @ViewBuilder cell: @escaping (Element) -> Cell,
                indexBarItem: @escaping (Key) -> any View,
                sectionPreview: ((Key) -> any View)? = nil,
                scrollAnimationDuration: Double = 0.2
    ) {
        self.dataSource = dataSource
        self.header = header
        self.cell = cell
        self.indexBarItem = indexBarItem
        self.sectionPreview = sectionPreview
        self.scrollAnimationDuration = scrollAnimationDuration
        self.indexBarItemDefaultDesign = nil
        self.sectionPreviewDefaultDesign = nil
    }
    
    /// IndexedScrollView 가 그려지는 기반 data
    ///
    /// Key: Index ex) 초성, 알파벳 ...
    ///
    /// [Element]: 어떠한 Index 에 매칭되는 Element 들의 리스트. ex) [Contact]
    internal let dataSource: OrderedDictionary<Key, [Element]>
    
    /// Header View Builder (밖에서 입력받은 Header 의 design)
    internal let header: (Key) -> SectionHeader
    /// Cell View Builder (밖에서 입력받은 Cell 의 design)
    internal let cell: (Element) -> Cell
    
    /// 오른쪽 스크롤 Item 의 ViewBuilder.
    internal let indexBarItem: (Key) -> any View
    /// 스크롤이 변경될 때마다 보여주는 SectionPreview ViewBuilder. nil 일때는 보여주지 않음.
    internal let sectionPreview: ((Key) -> any View)?
    
    /// 스크롤되는 애니메이션의 duration.
    private let scrollAnimationDuration: Double
    
    /// index Bar Item Text 의 디자인.
    internal let indexBarItemDefaultDesign: IndexedScrollViewTextDesign?
    /// section Preview Text 의 디자인.
    internal let sectionPreviewDefaultDesign: IndexedScrollViewTextDesign?
    
  
    @State
    private var bloc = IndexedScrollBloc()
    
    public var body: some View {
        let keys = dataSource.keys.sorted()
        
        ZStack {
            ScrollViewReader { proxy in
                HStack {
                    ScrollView {
                        LazyVStack {
                            ForEach(keys, id : \.self) { key in
                                Section(header: header(key)
                                    .id(key)) {
                                    let values = dataSource[key]!
                                    ForEach(values, id: \.self) { value in
                                        cell(value)
                                    }
                                }
                            }
                        }
                    }
                    
                    GeometryReader { geometry in
                        LazyVStack(alignment: .center) {
                            ForEach(keys, id: \.self) { key in
                                Button {
                                    scroll(proxy, to: key)
                                } label: {
                                    AnyView(indexBarItem(key))
                                }
                            }
                            .background(indexBarItemDefaultDesign?.backgroundColor)
                        }
                        // drag press only
                        .simultaneousGesture(DragGesture()
                            .onChanged { gesture in
                                let totalHeight = geometry.size.height
                                guard gesture.location.y < totalHeight else {
                                    scroll(proxy, to: dataSource.keys.last)
                                    return
                                }
                                
                                let cellHeight = totalHeight / CGFloat(dataSource.keys.count)
                                let cellIndex = Int(floor(gesture.location.y / cellHeight))

                                guard cellIndex > 0 else {
                                    scroll(proxy, to: dataSource.keys.first)
                                    return
                                }
                                scroll(proxy, to: dataSource.keys[cellIndex])
                            }
                        )
                        // TODO:
                        // keyboard 가 올라왔을시, 초성 인덱스 스크롤 영역이 overflow 되는 문제가 있어 keyboard 밑으로 화면이 rendering 될 수 있도록 추가.
//                        .adaptsToKeyboard()
                    }
                    .frame(maxWidth: 10)
                }
            }
            if sectionPreview != nil {
                SectionPreviewWidget(bloc: bloc, builder: sectionPreview!)
            }
        }
    }
    
    private func scroll(_ proxy: ScrollViewProxy,
                        to id: Key?) {
        if let id = id {
            if id != bloc.state.id {
                HapticManager.instance.impact(style: .soft)
                bloc.changeId(id)
                withAnimation(.linear(duration: scrollAnimationDuration)) {
                    proxy.scrollTo(id, anchor: .top)
                }
                bloc.hide()
            }
        }
    }
}

private extension IndexedScrollView {
    private struct SectionPreviewWidget: View {
        @StateObject
        var bloc: IndexedScrollBloc

        @State
        var opacity: Bool = false
        
        @ViewBuilder
        let builder: (Key) -> any View

        var body: some View {
            VStack {
                // 초성
                if (bloc.state.id != nil) {
                    AnyView(builder(bloc.state.id!))
                        .opacity(opacity ? 1 : 0)
                        .onReceive(bloc.$state) { state in
                            animtateOpacity(state.opacity)
                        }
                }
                else {
                    EmptyView()
                }
            }

        }

        private func animtateOpacity(_ opacity: Bool) {
            // appear 는 animation 적용 안함.
            if opacity {
                self.opacity = opacity
            }
            // hide 는 animation 적용
            else {
                withAnimation(.linear(duration: 0.8)) {
                    self.opacity = opacity
                }
            }
        }
    }
}
