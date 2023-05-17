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

    
    /// 마지막 페이지에서 nextContent 호출 시 호출
    private var didFinishedStepProcess: () -> Void = {}
    
    /// 처음 페이지에서 prevContent를 호출 시 호출
    private var exitStepProcess: () -> Void = {}
    
    /// 페이지 이동시 호출
    private var willStepSwitch: (StepContent<T>, StepContent<T>) -> Void = {_,_ in }
    
    public init(contents: [StepContent<T>],
         initialIndex: Int,
         config: StepControllerOptions = StepControllerOptions.defaultOption ) {
        self.contents = contents
        self.currentContent = contents[initialIndex]
        self.index = initialIndex
        self.config = config
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
                didFinishedStepProcess()
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
                exitStepProcess()
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

    func didFinishedStepProcess(perform: @escaping () -> Void) -> StepController {
        let controller = self
        controller.didFinishedStepProcess = perform
        return controller
    }
    
    func exitStepProcess (perform: @escaping () -> Void) -> StepController {
        let controller = self
        controller.exitStepProcess = perform
        return controller
    }
    
    
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
