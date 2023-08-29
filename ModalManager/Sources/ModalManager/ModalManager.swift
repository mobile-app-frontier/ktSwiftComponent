//
//  ModalManager.swift
//  GeniePhone
//
//  Created by kimrlyunah on 2023/02/09.
//

import Foundation
import SwiftUI
import Combine

/// modal controller 표출 작업의 상태
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

/// 사용자가 정의한 view를 모달로 만들어 띄워준다.
/// 
@MainActor
public class ModalManager {
    
    private static var instance: ModalManager? = nil
    
    /// ModalManager 사용 시 호출하는 메서드.
    /// - 최초 호출 시  ModalOrder, ModalStyle, 표출 설정으로 ModalManager 인스턴스를 초기화한다.
    /// - Parameters:
    ///     - modalOrder: modal이 표출되는 순서를 결정. 기본값은 StackOrder.
    ///     - modalStyle: modal 표출 형식 결정.
    ///     - ignoreIfPresenting: 다이얼로그를 1개만 표출. 이미 표출 중이라면 요청을 무시한다.
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
    
    /// modal 표출을 시도하는 동안(표출을 위한 작업이 진행 중) 또 다른 표출 요청이 들어올 경우 임시로 요청받은 modal을 보관해준다.
    private var modalControllersToPresent: [ModalController] = []
    
    /// modal 표출 형식을 결정한다.
    private(set) var modalStyle: ModalStyle = DefaultModalStyle()
    
    /// modal이 표출되는 순서를 결정한다.
    private(set) var modalOrder: ModalOrder = StackOrder()
    
    /// 다이얼로그를 1개만 출력하고 싶을 때 사용한다.
    private(set) var ignoreIfPresenting: Bool = false
    
    /// 현재 modal의 표출 상태를 바라보고 표출 여부를 결정하는 데에 사용된다.
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
    
    /// ModalManager는 사용자가 커스텀한 view를 controller를 이용하여 띄워준다.
    /// 사용자가 만든 view를 controller로 만드는 작업을 한 후 화면에 표출한다.
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
        debugPrint(modalOrder.modals())
    }
    
    /// modal 표출 상태를 확인하고, 현재 modal 표출 작업이 진행 중이라면 임시로 modal을 보관하고 있다가, 작업이 끝나면 표출한다.
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
    
    /// 생성된 Modal controller에 정의된 ModalStyle을 입힌다.
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
    
    /// modal controller를 앱의 가장 상위 컨트롤러 위에 띄운다.
    /// present가 완료되면 해당 modal이 최상위 컨트롤러가 된다.
    private func presentSequentially(_ modalControllerToPresent: ModalController, _ animated: Bool) {
        let promisingTopViewController = findTopViewController()
        promisingTopViewController?.present(modalControllerToPresent, animated: true) {
            self.updateState(.initState)
        }
    }
}
