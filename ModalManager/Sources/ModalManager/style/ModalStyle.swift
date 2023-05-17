//
//  ModalStyle.swift
//  GeniePhone
//
//  Created by kimrlyunah on 2023/02/16.
//

import Foundation
import SwiftUI


public protocol ModalStyle {
    
    var modalPresentationStyle : UIModalPresentationStyle { get }
    
    /// Modal 창 외부 배경색
    var modalBackground: UIColor { get }
    
    var modalTransitionStyle: UIModalTransitionStyle { get }
}

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
