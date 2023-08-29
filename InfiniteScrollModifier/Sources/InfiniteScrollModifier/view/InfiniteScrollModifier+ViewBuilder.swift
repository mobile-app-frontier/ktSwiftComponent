//
//  InfiniteScrollModifier+ViewBuilder.swift
//  
//
//  Created by kimrlyunah on 2023/04/19.
//

import SwiftUI

/// 설정된 프로그래스 뷰가 있으면 해당 뷰를 보여주고, 없을 시 디폴트 뷰를 표출.
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
