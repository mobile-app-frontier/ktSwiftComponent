//
//  StepBloc.swift
//  GeniePhone
//
//  Created by pjx on 2023/03/07.
//

import Foundation
import SwiftUI



//MARK: - Step Controller
public class StepController<T>: ObservableObject {
    public let config: StepControllerOptions
    
    /// step controller's step index
    @Published
    public private(set) var index: Int
    
    /// total process
    @Published
    public private(set) var contents: [StepContent<T>]
    
    /// current content
    @Published
    public private(set) var currentContent: StepContent<T>
    
    @Published
    public private(set) var stepState: StepViewState 

    

    /// 페이지 이동시 호출
    private var willStepSwitch: (StepContent<T>, StepContent<T>) -> Void = {_,_ in }
    
    public init(contents: [StepContent<T>],
         initialIndex: Int,
         config: StepControllerOptions = StepControllerOptions.defaultOption ) {
        self.contents = contents
        self.currentContent = contents[initialIndex]
        self.index = initialIndex
        self.config = config
        self.stepState = .start
    }
    
    func getContentIndex(content: StepContent<T>) -> Int? {
        return contents.firstIndex(of: content)
    }
    
}

//MARK: - step controller functions
public extension StepController {
    func appendContent(content: StepContent<T>) {
        Task {
            await MainActor.run {
                contents.append(content)
            }
        }
    }
    
    func nextContent() {
        /// if last page
        if index == contents.endIndex - 1{
            if config.cycleBehavior {
                switchContentIndex(nextIndex: 0)
                return
            } else {
                stepState = .complete
                return
            }
        }
        
        ///switchContent
        switchContentIndex(nextIndex: index + 1)
    }
    
    func prevContent() {
        /// if first page
        if index == 0 {
            if config.cycleBehavior {
                switchContentIndex(nextIndex: contents.endIndex - 1)
                return
            } else {
                stepState = .exit
                return
            }
        }
        
        ///switchContent
        switchContentIndex(nextIndex: index - 1)
    }
    
}

//MARK: - private functions
extension StepController {
    
    private func switchContentIndex(nextIndex: Int) {
        Task {
            await MainActor.run {
                stepState = .inprogress
                
                index = nextIndex
                let nextContent = contents[index]
                willStepSwitch(currentContent, nextContent)
                currentContent = nextContent
            }
        }
    }
}


//MARK: - closure
public extension StepController {
    
    /**
     param
        param1: StepContent : prevStep
        param2: StepContent : nextStep
     */
    func willStepSwitchProcess(perform: @escaping (StepContent<T>, StepContent<T>) -> Void) -> StepController {
        let controller = self
        controller.willStepSwitch = perform
        return controller
    }
}
