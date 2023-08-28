//
//  File.swift
//  
//
//  Created by kh Jang on 2023/08/01.
//

import Foundation
import os
// TODO: release에서 logger도 찍을 지? (playground에서만 안찍히는 건지는 확인필요,,)
// TODO: DEBUG 태그 전처리자..?

/// Log
public class Log {
    static private var filter: LogFilter = LogFilter()
    
    /// Log 초기화
    /// 프로젝트 전체에 적용되는 LogFilter를 설정해 줄 수 있음.
    /// - Parameter option: ``LogFilter`` 참고.
    public static func initialize(option: LogFilter) {
        self.filter = option
    }
    
    /// Log level 지정해서 찍을 수 있는 로그
    /// - Parameters:
    ///   - message: 실제 출력될 메세지. 타입 상관 없음.
    ///   - file: 현재 로그가 찍힌 파일 이름. 직접 지정해 줄 수 있으나 지정해 주지 않으면 실제 로그를 찍은 파일 이름이 출력됨.
    ///   - line: 로그가 찍힌 라인. 직접 지정해 줄 수 있으나 지정해 주지 않으면 실제 로그를 찍은 파일의 라인 수가 출력됨.
    ///   - funcname: 로그가 찍힌 함수 이름. 직접 지정해 줄 수 있으나 지정해 주지 않으면 실제 로그를 찍은 함수 이름이 출력됨.
    ///   - customFilter: 로그를 필터링해서 보고 싶을 때 사용 ``LogFilter`` 참조
    /// - Output Message: [getCurrentTime()] (level.tag) [file:line] funcname message
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
    
    /// Log level Info 인 로그
    /// - Parameters:
    ///   - message: 실제 출력될 메세지. 타입 상관 없음.
    ///   - file: 현재 로그가 찍힌 파일 이름. 직접 지정해 줄 수 있으나 지정해 주지 않으면 실제 로그를 찍은 파일 이름이 출력됨.
    ///   - line: 로그가 찍힌 라인. 직접 지정해 줄 수 있으나 지정해 주지 않으면 실제 로그를 찍은 파일의 라인 수가 출력됨.
    ///   - funcname: 로그가 찍힌 함수 이름. 직접 지정해 줄 수 있으나 지정해 주지 않으면 실제 로그를 찍은 함수 이름이 출력됨.
    ///   - customFilter: 로그를 필터링해서 보고 싶을 때 사용 ``LogFilter`` 참조
    /// - Output Message: [getCurrentTime()] (I) [file:line] funcname message
    public static func i<T>(
        _ message: T,
        file: String = #file,
        _ line: Int = #line,
        _ funcname: String = #function,
        customFilter: LogFilter? = nil
    ) {
        log(message, level: .info, file: file, line, funcname, customFilter: customFilter)
    }
    
    /// Log level debug 인 로그
    /// - Parameters:
    ///   - message: 실제 출력될 메세지. 타입 상관 없음.
    ///   - file: 현재 로그가 찍힌 파일 이름. 직접 지정해 줄 수 있으나 지정해 주지 않으면 실제 로그를 찍은 파일 이름이 출력됨.
    ///   - line: 로그가 찍힌 라인. 직접 지정해 줄 수 있으나 지정해 주지 않으면 실제 로그를 찍은 파일의 라인 수가 출력됨.
    ///   - funcname: 로그가 찍힌 함수 이름. 직접 지정해 줄 수 있으나 지정해 주지 않으면 실제 로그를 찍은 함수 이름이 출력됨.
    ///   - customFilter: 로그를 필터링해서 보고 싶을 때 사용 ``LogFilter`` 참조
    /// - Output Message: [getCurrentTime()] (D) [file:line] funcname message
    public static func d<T>(
        _ message: T,
        file: String = #file,
        _ line: Int = #line,
        _ funcname: String = #function,
        customFilter: LogFilter? = nil) {
            log(message, level: .debug, file: file, line, funcname, customFilter: customFilter)
        }
    
    /// Log level error 인 로그
    /// - Parameters:
    ///   - message: 실제 출력될 메세지. 타입 상관 없음.
    ///   - file: 현재 로그가 찍힌 파일 이름. 직접 지정해 줄 수 있으나 지정해 주지 않으면 실제 로그를 찍은 파일 이름이 출력됨.
    ///   - line: 로그가 찍힌 라인. 직접 지정해 줄 수 있으나 지정해 주지 않으면 실제 로그를 찍은 파일의 라인 수가 출력됨.
    ///   - funcname: 로그가 찍힌 함수 이름. 직접 지정해 줄 수 있으나 지정해 주지 않으면 실제 로그를 찍은 함수 이름이 출력됨.
    ///   - customFilter: 로그를 필터링해서 보고 싶을 때 사용 ``LogFilter`` 참조
    /// - Output Message: [getCurrentTime()] (E) [file:line] funcname message
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
