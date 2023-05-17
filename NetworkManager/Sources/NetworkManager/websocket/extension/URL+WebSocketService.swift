//
//  File.swift
//  
//
//  Created by 박주철 on 2023/05/01.
//

import Foundation




extension URL {
    func getHost() -> String? {
        if #available(iOS 16.0, *) {
            return self.host()
        } else {
            // Fallback on earlier versions
            return self.host
        }
    }
}
