//
//  StepContent.swift
//  GeniePhone
//
//  Created by pjx on 2023/03/08.
//

import Foundation
import SwiftUI

/// 스탭의 내부 컨텐츠 항목
public struct StepContent<T>: Identifiable {
    public let step: T
    
    public let id: UUID = UUID()
    
    @ViewBuilder
    let content: () -> AnyView
    
    public init(step:T, content: @escaping () -> AnyView) {
        self.step = step
        self.content = content
    }
}

//MARK: - equatable
extension StepContent: Equatable {
    public static func == (lhs: StepContent, rhs: StepContent) -> Bool {
        return lhs.id == rhs.id
    }
}
