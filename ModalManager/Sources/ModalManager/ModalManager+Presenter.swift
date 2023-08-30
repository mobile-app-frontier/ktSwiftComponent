//
//  ModalManager+showModal.swift
//  GeniePhone
//
//  Created by kimrlyunah on 2023/02/16.
//

import Foundation
import SwiftUI

// MARK: - public show functions
public extension ModalManager {
    /// SwiftUI View를 모달에 올려 표출한다.
    /// > Warning: 모달 해제 시에 `dismissModal`을 호출해야 한다.
    /// - Parameters:
    ///     - modalWindowStyle: 모달 창 스타일 정의.
    ///     - modalContent: 모달에 표출할 SwiftUI View.
    func show(
        modalWindowStyle: ModalWindowStyle = ResizableModalWindowStyle(),
        arbitraryMarginValue: CGFloat = 0,
        modalContent: @escaping () -> some View
    ) {
        
        if ModalManager.getInstance().ignoreIfPresenting && ModalManager.getInstance().modalOrder.modals() != 0 {
            return
        }
        let customModalView: ModalView = ModalView(
            contentBuilder: modalContent,
            modalWindowStyle: modalWindowStyle,
            arbitraryMarginValue: arbitraryMarginValue
        )
        createModalController(customModalView)
    }
    
}

// MARK: - public dismiss function
public extension ModalManager {
    /// 최상단에 표출 중인 모달을 내려준다.
    func dismissModal() {
        if currentState == .initState {
            if let controller = modalOrder.topModal() {
                updateState(.onDismiss)
                modalOrder.remove()
                controller.dismiss(animated: false) {
                    self.updateState(.initState)
                }
            }
        }
    }
}
