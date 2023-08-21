//
//  StepView.swift
//  GeniePhone
//
//  Created by pjx on 2023/03/07.
//

import Foundation
import SwiftUI


public struct StepView<T> {
    @State
    var currentIndex: Int
    
    @ObservedObject
    var controller: StepController<T>
    
    let useAnimation: Bool
    ///
    /// - Parameters:
    ///  - controller: Step Controller
    ///  - useAnimation: content변경시 animation을 사용할 지 말 지 에 대한 요소
    public init(controller: StepController<T>, useAnimation: Bool = true) {
        self.controller = controller
        self.currentIndex = controller.index
        self.useAnimation = useAnimation
    }
}

//MARK: - View
extension StepView: View {
    public var body: some View {
        ZStack {
            ForEach (controller.contents) { content in
                if let index = controller.getContentIndex(content: content) , index == currentIndex{
                    content.content()
                        .environmentObject(controller)
                        .transition(.asymmetric(insertion: .opacity, removal: .opacity))
                }
            }
        }.onReceive(controller.$index) { index in
            if useAnimation  {
                /// do animation style
                withAnimation {
                    currentIndex = index
                }
            } else {
                /// not animate
                  currentIndex = index
            }
        }
    }
}

