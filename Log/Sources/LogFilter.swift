//
//  File.swift
//  
//
//  Created by kh Jang on 2023/08/02.
//

import Foundation

/// Log Filter
/// - remark: isConsoleLogOn 을 제외한 다른 필터는 DEBUG 일때만 동작
public struct LogFilter {
    /// Release 모드 일 때 Console에서 볼 수 있는 OSLog를 찍을 지 여부
    let isConsoleLogOn: Bool
    /// 원하는 파일만 필터링 해서 보여줄 때 사용
    ///
    /// 보기를 원하는 파일명만(확장자 제외 하고) 리스트로 넘겨주면 됨.
    /// ```swift
    ///   // example
    ///   let option = LogFileterOption(fileNames: ["MyPlayground"])
    /// ```
    let fileNames: [String]
    /// Log level을 필터링 해서 보고 싶을 때 사용
    let level: LogLevel
    
    public init(isReleaseLogOn: Bool = false, fileNames: [String] = [], level: LogLevel = .debug) {
        self.isConsoleLogOn = isReleaseLogOn
        self.fileNames = fileNames
        self.level = level
    }
}

extension LogFilter {
    internal func check(fileName: String, level: LogLevel) -> Bool {
        return checkValid(fileName: fileName) && checkValid(level: level)
    }
    /// 현재 file 이름이 유효한지 체크
    private func checkValid(fileName: String) -> Bool {
        return fileNames.isEmpty || fileNames.contains(where: { $0 == fileName })
    }
    
    private func checkValid(level: LogLevel) -> Bool {
        return level >= self.level
    }
}
