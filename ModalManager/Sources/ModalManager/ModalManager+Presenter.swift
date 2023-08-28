//
//  ModalManager+showModal.swift
//  GeniePhone
//
//  Created by kimrlyunah on 2023/02/16.
//

import Foundation
import SwiftUI

/**
 *
 ** 예시 **
 *
 ModalManager.instance.show(
     modalContent: {
         VStack {
             Button {
 *             /**
                *     모달을 끄려면 명시적으로 dismissModal을 호출해야 합니다.
                */
                 ModalManager.instance.dismissModal()
             } label: {
                 Text("button")
             }
             Button {
                 print("z")
             } label: {
                 Text("hihih")
             }

         }
     }
 )
*/

// MARK: - public show functions
public extension ModalManager {
    /*
     Modal을 닫으려면 ModalManager.instance.dismissModal() 호출
     */
    func show(
        modalWindowStyle: ModalWindowStyle = ResizableModalWindowStyle(),
        arbitraryMarginValue: CGFloat = 0,
        modalContent: @escaping () -> some View
    ) {
        
        // 이미 표출 중인 모달이 있으면 표출하지 않습니다.
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
