//
//  InfiniteScrollModifier+ViewBuilder.swift
//  
//
//  Created by kimrlyunah on 2023/04/19.
//

import SwiftUI

extension InfiniteScrollModifier {
    @ViewBuilder
    func refreshProgressView() -> some View {
        if delegate.refreshProgressView == nil {
            InfiniteScrollDefaultProgressView()
        } else {
            AnyView(delegate.refreshProgressView!())
        }
    }
    @ViewBuilder
    func infiniteProgressView() -> some View {
        if delegate.infiniteProgressView == nil {
            ProgressView()
        } else {
            AnyView(delegate.infiniteProgressView!())
        }
    }
}
