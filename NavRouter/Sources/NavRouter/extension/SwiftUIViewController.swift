//
//  File.swift
//  
//
//  Copyright (c) 2016 kt corp. All rights reserved.
//  This is a proprietary software of kt corp, and you may not use this file
//  except in compliance with license agreement with kt corp. Any redistribution
//  or use of this software, with or without modification shall be strictly
//  prohibited without prior written approval of kt corp, and the copyright
//  notice above does not evidence any actual or intended publication of such
//  software.
//

import Foundation
import UIKit
import SwiftUI

class SwiftUIViewController<Content: View>: UIHostingController<Content> {
    
    var onViewDidAppear: ((UINavigationController?)-> Void)?
    
    convenience init(rootView: Content, onViewDidAppear: @escaping ((UINavigationController?)-> Void)) {
        self.init(rootView: rootView)
        self.onViewDidAppear = onViewDidAppear
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // view didloaded
        onViewDidAppear?(self.navigationController)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        onViewDidAppear?(self.navigationController)
    }
}
