//
//  OnViewDidLoad.swift
//  ExamplePollingCenter
//
//  Created by 이소정 on 2023/08/24.
//

import SwiftUI

struct ViewDidLoadModifier: ViewModifier {
    @State private var viewDidLoad = false
        let action: (() -> Void)?
        
        func body(content: Content) -> some View {
            content
                .onAppear {
                    if viewDidLoad == false {
                        viewDidLoad = true
                        action?()
                    }
                }
        }
}

extension View {
    func onViewDidLoad(perform action: (() -> Void)? = nil) -> some View {
        self.modifier(ViewDidLoadModifier(action: action))
    }
}
