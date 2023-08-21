//
//  StepControllerOptions.swift
//  GeniePhone
//
//  Created by pjx on 2023/03/08.
//

import Foundation

/// StepController의 옵션으로 내부 동작을 정의해 줄 수 있다.
public struct StepControllerOptions {
    /// 끝에 도달했을 시 자동으로 처음으로 인덱스를 변경해주는 기능.
    let cycleBehavior: Bool
    
    init(cycleBehavior: Bool) {
        self.cycleBehavior = cycleBehavior
    }
    
    /// default 옵션
    public static let defaultOption: StepControllerOptions = StepControllerOptions(cycleBehavior: false)
}
