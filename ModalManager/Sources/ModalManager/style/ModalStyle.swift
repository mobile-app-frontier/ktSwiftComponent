//
//  ModalStyle.swift
//  GeniePhone
//
//  Created by kimrlyunah on 2023/02/16.
//

import Foundation
import SwiftUI

/// 모달 표출 형식을 정의한다.
/// - Parameters:
///     - modalPresentationStyle: modal을 띄우는 형식 정의.
///     - modalBackground: modal 창 외부 배경 색상 정의.
///     - modalTransitionStyle: modal 전환 효과 정의.
public protocol ModalStyle {
    
    /// modal을 띄우는 형식을 정의한다.
    var modalPresentationStyle : UIModalPresentationStyle { get }
    
    /// modal 창 외부 배경 색상을 정의한다.
    var modalBackground: UIColor { get }
    
    /// modal이 전환되는 효과를 정의한다.
    var modalTransitionStyle: UIModalTransitionStyle { get }
}

/// 디폴트로 사용되는 모달 표출 형식.
public struct DefaultModalStyle : ModalStyle {
    public let modalPresentationStyle: UIModalPresentationStyle
    public let modalBackground: UIColor
    public let modalTransitionStyle: UIModalTransitionStyle
    
    init(
        modalPresentationStyle: UIModalPresentationStyle = .overCurrentContext,
        modalBackground: UIColor = UIColor.black.withAlphaComponent(0.2),
         modalTransitionStyle: UIModalTransitionStyle = .crossDissolve
    ) {
        self.modalPresentationStyle = modalPresentationStyle
        self.modalBackground = modalBackground
        self.modalTransitionStyle = modalTransitionStyle
    }
}
