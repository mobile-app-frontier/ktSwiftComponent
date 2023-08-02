//
//  File.swift
//  
//
//  Created by kh Jang on 2023/08/01.
//

import Foundation
import os
// NOTE:
// 2. release에서 logger도 찍을 지? (이게 playground에서만 안찍히는 건지는 확인해봐야되기는 하는데,,)
// TODO: DEBUG 태그 전처리자..?

public class Log {
    static private var filter: LogFilter = LogFilter()
    
    public static func initialize(option: LogFilter) {
        self.filter = option
    }
    
    public static func log<T>(
        _ message: T,
        level: LogLevel,
        file: String = #file,
        _ line: Int = #line,
        _ funcname: String = #function,
        customFilter: LogFilter? = nil
    ) {
        let fileNameWithExt = NSURL(fileURLWithPath: file).lastPathComponent ?? "UnkownFile"
        let fileName = String(fileNameWithExt.split(separator: ".").first ?? "UnkownFile")
        let logMessage = "[\(getCurrentTime())] (\(level.tag)) [\(fileName):\(line)] \(funcname): \(message)"
        let currentFilter = customFilter ?? filter
        #if DEBUG
        if currentFilter.check(fileName: fileName, level: level) {
            print(logMessage)
        }
        #else
        if level > LogLevel.debug {
            print(logMessage)
        }
        #if RELEASELOG
        let logger = Logger(subsystem: "MeetsSdk", category: level.categoryName)
        logger.log(level: level.osType, "\(logMessage, privacy: .public)")
        #else
        // 전 처리자 RELEASELOG가 on이 아니면
        if currentFilter.isConsoleLogOn {
            let logger = Logger(subsystem: "MeetsSdk", category: level.categoryName)
            logger.log(level: level.osType, "\(logMessage, privacy: .public)")
        }
        #endif
        #endif
    }
    
    public static func i<T>(
        _ message: T,
        file: String = #file,
        _ line: Int = #line,
        _ funcname: String = #function,
        customFilter: LogFilter? = nil
    ) {
        log(message, level: .info, file: file, line, funcname, customFilter: customFilter)
    }
    
    public static func d<T>(
        _ message: T,
        file: String = #file,
        _ line: Int = #line,
        _ funcname: String = #function,
        customFilter: LogFilter? = nil) {
            log(message, level: .debug, file: file, line, funcname, customFilter: customFilter)
        }
    
    public static func e<T>(
        _ message: T,
        file: String = #file,
        _ line: Int = #line,
        _ funcname: String = #function,
        customFilter: LogFilter? = nil) {
        log(message, level: .error, file: file, line, funcname, customFilter: customFilter)
    }
    
    private static func getCurrentTime() -> String {
        let date = DateFormatter()
        date.locale = Locale(identifier: Locale.current.identifier)
        date.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        date.dateFormat = "yyy-MM-dd HH:mm:ss"
        return date.string(from: Date())
    }
}
