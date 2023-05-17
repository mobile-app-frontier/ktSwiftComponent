//
//  AnimateVisibleView.swift
//  GeniePhone
//
//  Created by pjx on 2023/03/09.
//

import SwiftUI


public extension View {
    @ViewBuilder
    func animateVisible(visible: Bool) -> some View {
        AnimateVisibleView(content: {
            self
        }, visible: visible)
    }
}


public struct AnimateVisibleView<Content: View> {
    
    /// visible == true시 나오는.view
    @ViewBuilder
    let content: () -> Content
    
    ///외부에서 지정하는 visible 값.
    var visible: Bool
    
    /// internal visible state
    /// animation을 주기 위함.
    @State
    private var showContent: Bool
    
    public init(content: @escaping () -> Content, visible: Bool) {
        self.content = content
        self.visible = visible
        self.showContent = false
    }
    
}


//MARK: - View
extension AnimateVisibleView : View{
    
    public var body: some View {
        buildContent()
            .onChange(of: visible) { newValue in
                withAnimation {
                    showContent = newValue
                }
        }
    }
}

//MARK: - private ui functions

extension AnimateVisibleView {
    /// build content
    /// if showContent
    ///     build content
    /// else
    ///     build empty view
    private func buildContent() -> AnyView {
        if showContent {
            return contentView()
        } else {
            return emptyView()
        }
    }
    
    /// invisible 상태에서의 view
    private func emptyView() -> AnyView {
        return AnyView(EmptyView())
    }
    
    /// visible 상태에서의 content
    private func contentView() -> AnyView {
        return AnyView(
            content()
                .transition(
                    .asymmetric(insertion: .opacity,
                                removal: .opacity)
                )
        )
    }
}
