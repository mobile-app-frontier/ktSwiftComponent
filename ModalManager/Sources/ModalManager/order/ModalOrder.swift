//
//  ModalOrderManager.swift
//  GeniePhone
//
//  Created by kimrlyunah on 2023/02/10.
//

import Foundation
import SwiftUI

/// 모달 순서 등의 관리에 사용한다.
public protocol ModalOrder {

    /// - Parameters:
    ///     - controller: 관리할 ModalController.
    func add(
        controller: ModalController
    )

    func remove()

    func topModal() -> ModalController?

    func modals() -> Int

}
