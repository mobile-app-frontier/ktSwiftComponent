//
//  ModalManager.swift
//  GeniePhone
//
//  Created by kimrlyunah on 2023/02/09.
//

import Foundation
import SwiftUI
import Combine

public enum ModalPresentableState {
    /// present / dismiss 작업을 수행하지 않는 상태
    case initState
    /// someController.present 호출되어 작업이 수행되고 있는 상태
    case onPresent
    /// someController.dismiss 호출되어 작업이 수행되고 있는 상태
    case onDismiss
    
    /*
     RootViewController 위에 1개의 컨트롤러를 띄울 수 있는데,
     A라는 ModalController가 present 수행 중일 때
     B라는 ModalController가 present하기 위해 rootView를 찾으면,
     아직 A가 RootView가 되지 않은 상태에서 찾게 된다. -> [Warning] attempt to present on while a presentation is in progress
     A의 present 작업이 끝날 때까지 A에서는 onPresent 상태를 들고 있어야 한다.
     A 작업이 끝나면 present의 핸들러에서 initState 상태로 전환한다.
     */
}

@MainActor
public class ModalManager {
    
    private static var instance: ModalManager? = nil
    
    public static func getInstance(
        modalOrder: ModalOrder? = nil,
        modalStyle: ModalStyle? = nil,
        ignoreIfPresenting: Bool? = nil
    ) -> ModalManager {
        guard ModalManager.instance == nil else {
            return ModalManager.instance!
        }
        ModalManager.instance = ModalManager(modalOrder: modalOrder, modalStyle: modalStyle, ignoreIfPresenting: ignoreIfPresenting)
        return ModalManager.instance!
    }
    
    private var modalControllersToPresent: [ModalController] = []
    
    private(set) var modalStyle: ModalStyle = DefaultModalStyle()
    
    private(set) var modalOrder: ModalOrder = StackOrder()
    
    /// 다이얼로그를 1개만 출력하고 싶을 때 사용
    private(set) var ignoreIfPresenting: Bool = false
    
    var currentState: ModalPresentableState = .initState
    
    private init() {}
    
    private init(
        modalOrder: ModalOrder? ,
        modalStyle: ModalStyle?,
        ignoreIfPresenting: Bool? = nil
    ) {
        self.modalOrder = modalOrder == nil ? StackOrder() : modalOrder!
        self.modalStyle = modalStyle == nil ? DefaultModalStyle() : modalStyle!
        self.ignoreIfPresenting = ignoreIfPresenting == nil ? false : ignoreIfPresenting!
    }
}

// MARK: - internal ModalManager functions
extension ModalManager {
    
    func createModalController(
        _ customModalView: ModalView
    ) {
        
        let customModalController: ModalController = ModalController(
            customModal: customModalView
        )
        
        applyModalStyle(customModalController: customModalController)
        
        if currentState == .initState {
            updateState(.onPresent)
            modalOrder.add(controller: customModalController)
            presentModalController(customModalController)
        } else {
            modalControllersToPresent.append(customModalController)
        }
    }
    
    func updateState(_ newState: ModalPresentableState) {
        if newState == .initState {
            if !modalControllersToPresent.isEmpty {
                currentState = .onPresent
                let controller = modalControllersToPresent.removeFirst()
                modalOrder.add(controller: controller)
                presentModalController(controller)
            } else {
                currentState = newState
            }
        } else {
            currentState = newState
        }
    }
}

// MARK: - private ModalManager functions
extension ModalManager {
    
    private func applyModalStyle(customModalController: ModalController) {
        customModalController.modalPresentationStyle = modalStyle.modalPresentationStyle
        customModalController.view.backgroundColor = modalOrder.modals() == 0 ? modalStyle.modalBackground : UIColor.clear
        customModalController.modalTransitionStyle = modalStyle.modalTransitionStyle
    }
    
    private func presentModalController(_ customModalController: ModalController)  {
        if modalOrder is StackOrder {
            presentSequentially(customModalController, true)
        }
    }
    
    private func presentSequentially(_ modalControllerToPresent: ModalController, _ animated: Bool) {
        let promisingTopViewController = findTopViewController()
        promisingTopViewController?.present(modalControllerToPresent, animated: true) {
            self.updateState(.initState)
        }
    }
}
