//
//  ModalOrderManager.swift
//  GeniePhone
//
//  Created by kimrlyunah on 2023/02/10.
//

import Foundation
import SwiftUI

public protocol ModalOrder {

    func add(
        controller: ModalController
    )

    func remove()

    func topModal() -> ModalController?

    func modals() -> Int

}
