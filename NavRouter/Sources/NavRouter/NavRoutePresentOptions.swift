//
//  NavRoutePresentOptions.swift
//  
//
//  Created by pjx on 2023/04/17.
//
import SwiftUI

/// present option
/// default color : black with alpha 0.2
/// default transitionStyle : crossDissolve
/// default presentationStyle : over current context
public struct NavRoutePresentOptions {
    
    let modalTransitionStyle: UIModalTransitionStyle

    let modalPresentationStyle: UIModalPresentationStyle

    let backgroundColor: UIColor
    
    
    public init(modalTransitionStyle: UIModalTransitionStyle = .crossDissolve,
         modalPresentationStyle: UIModalPresentationStyle = .overCurrentContext,
         backgroundColor: UIColor = UIColor.black.withAlphaComponent(0.2)) {
        self.modalTransitionStyle = modalTransitionStyle
        self.modalPresentationStyle = modalPresentationStyle
        self.backgroundColor = backgroundColor
    }
}
