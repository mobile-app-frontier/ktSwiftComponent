//
//  StepControllerOptions.swift
//  GeniePhone
//
//  Created by pjx on 2023/03/08.
//

import Foundation

public struct StepControllerOptions {
    let cycleBehavior: Bool
    
    init(cycleBehavior: Bool) {
        self.cycleBehavior = cycleBehavior
    }
    
    
    public static let defaultOption: StepControllerOptions = StepControllerOptions(cycleBehavior: false)
}
