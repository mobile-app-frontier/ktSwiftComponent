//
//  SequentialOrder.swift
//  GeniePhone
//
//  Created by kimrlyunah on 2023/02/16.
//

import Foundation
import SwiftUI
import Combine

/// 모달이 표출되는 대로 Array에 추가되고, 내려갈 때 제거된다.
/// 가장 최상단에 표출된 모달부터 제거한다.
public class StackOrder: ModalOrder {
    
    /// 모달 관리를 위해 사용
    private var modalReferenceArray: [ModalController] = []
    
    /// 표출된 모달을 모달 관리 리스트에 추가
    public func add(
        controller: ModalController
    ) {
        modalReferenceArray.append(controller)
    }
    
    /// 모달 컨트롤러를 관리 리스트에서 제거
    public func remove() {
        modalReferenceArray.removeLast()
    }
    
    /// 현재 최상단 표출 중인 모달 컨트롤러 리턴
    /// - Returns: 관리 리스트에 마지막으로 들어왔던 모달 컨트롤러
    public func topModal() -> ModalController? {
        return modalReferenceArray.last ?? nil
    }
    
    /// 관리 리스트에 등록되어있는 모달 컨트롤러 개수
    public func modals() -> Int {
        return modalReferenceArray.count
    }
    
}
