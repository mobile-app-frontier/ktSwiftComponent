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
    
    /// stepView의 상태
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
    
    /// content의 인덱스
    /// content가 list안에 없을 시 null을 리턴한다.
    func getContentIndex(content: StepContent<T>) -> Int? {
        return contents.firstIndex(of: content)
    }
    
}

//MARK: - step controller functions
public extension StepController {
    /// 신규 타입의 content를 리스트에 추가
    /// - Parameters:
    ///  - content: 추가 할 새로운 content 
    func appendContent(content: StepContent<T>) {
        Task {
            await MainActor.run {
                contents.append(content)
            }
        }
    }
    
    /// 다음 content 노출
    func nextContent() {
        // if last page
        if index == contents.endIndex - 1{
            if config.cycleBehavior {
                switchContentIndex(nextIndex: 0)
                return
            } else {
                stepState = .complete
                return
            }
        }
        
        // switchContent
        switchContentIndex(nextIndex: index + 1)
    }
    
    /// 이전 content를 노출
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
    
    
    /// 다음 스탭으로 가기 전 상태를 callbak
    /// - Parameters:
    ///  - perform: 현재 상태와 다음 상태를 받을 수 있다
    ///
    func willStepSwitchProcess(perform: @escaping (StepContent<T>, StepContent<T>) -> Void) -> StepController {
        let controller = self
        controller.willStepSwitch = perform
        return controller
    }
}
