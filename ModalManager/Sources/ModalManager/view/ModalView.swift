//
//  CustomModal.swift
//  GeniePhone
//
//  Created by kimrlyunah on 2023/02/07.
//

import SwiftUI

public struct ModalView: View {
    
    @ViewBuilder
    let contentBuilder: () -> any View
    
    /// status bar, navigation bar, tab bar 높이가 모두 포함된 기기 화면 전체 높이
    let deviceHeight: CGFloat = UIScreen.main.bounds.height
    let deviceWidth: CGFloat = UIScreen.main.bounds.width
    
    let topSafeArea: CGFloat = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
    let bottomSafeArea: CGFloat = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
    let leftSafeArea: CGFloat = UIApplication.shared.windows.first?.safeAreaInsets.left ?? 0
    let rightSafeArea: CGFloat = UIApplication.shared.windows.first?.safeAreaInsets.right ?? 0
    
    /// 최대 길이/너비로 띄워질 경우 아름답지 않아서 추가된 파라미터
    let arbitraryMarginValue: CGFloat = 50
    
    let modalWindowStyle: ModalWindowStyle
    
    private var safeHeight : CGFloat {
        
        //TODO device에 따라 최대 height 고려
        let availableHeight = UIScreen.main.bounds.height - bottomSafeArea - topSafeArea - arbitraryMarginValue

        return availableHeight <= modalWindowStyle.windowHeight ? availableHeight : modalWindowStyle.windowHeight
    }
    
    private var safeWidth: CGFloat {
        
        let availableWidth = UIScreen.main.bounds.width - leftSafeArea - rightSafeArea - arbitraryMarginValue
        
        return availableWidth <= modalWindowStyle.windowWidth ? availableWidth : modalWindowStyle.windowWidth
    }
    
    public var body: some View {
        Group {
                VStack {
                    Spacer()
                        .frame(height: 1)
                    GeometryReader { geometry in
                        AnyView(contentBuilder())
                            .frame(
                                width: geometry.size.width,
                                height: geometry.size.height
                            )
                        Spacer()
                            .frame(height: 1)
                    }
                }
                .frame(
                    width: safeWidth,
                    height: safeHeight,
                    alignment: .center // 뷰 정렬
                )
                .padding(modalWindowStyle.windowPadding) // 모달창 - 모달컨텐츠 사이의 패딩
                .background(modalWindowStyle.windowBackGround) // 배경 색상, 이미지, 뷰 설정
                .foregroundColor(modalWindowStyle.windowForeGround) // 전경 색상
                .cornerRadius(modalWindowStyle.windowCornerRadius) // 뷰 모서리를 둥글게 만듦
                .shadow(radius: modalWindowStyle.windowShadow) // 뷰에 그림자 추가
                .font(modalWindowStyle.windowFont) // 폰트 설정
        }
    }
}
