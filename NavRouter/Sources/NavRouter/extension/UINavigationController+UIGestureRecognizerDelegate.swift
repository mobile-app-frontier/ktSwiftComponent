//
//  UINavigationController+UIGestureRecognizerDelegate.swift
//  
//
//  Created by pjx on 2023/03/27.
//
#if canImport(UIKit)
import UIKit

extension UINavigationController: ObservableObject, UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
        self.isNavigationBarHidden = true
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

#endif
