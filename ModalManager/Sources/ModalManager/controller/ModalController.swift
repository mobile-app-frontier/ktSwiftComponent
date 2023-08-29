//
//  CustomModalController.swift
//  GeniePhone
//
//  Created by kimrlyunah on 2023/02/06.
//

import Foundation
import UIKit
import SwiftUI

/// SwiftUI ModalView를 컨트롤러로 변환한다.
public class ModalController: UIHostingController<ModalView> {
    var customModal: ModalView
    
    init(customModal: ModalView) {
        self.customModal = customModal
        super.init(rootView: customModal)
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
