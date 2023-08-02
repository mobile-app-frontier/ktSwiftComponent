import os

public enum LogLevel: Int {
    case debug
    case info
    case error
    
}
// MARK: - LogLevel+Operator
extension LogLevel {
    static func >=(lhs: LogLevel, rhs: LogLevel) -> Bool {
        return lhs.rawValue >= rhs.rawValue
    }
    static func >(lhs: LogLevel, rhs: LogLevel) -> Bool {
        return lhs.rawValue > rhs.rawValue
    }
    
    static func <=(lhs: LogLevel, rhs: LogLevel) -> Bool {
        return lhs.rawValue <= rhs.rawValue
    }
    static func <(lhs: LogLevel, rhs: LogLevel) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

// MARK: - LogLevel+OSLog
extension LogLevel {
    var categoryName: String {
        switch self {
        case .debug:
            return "DEBUG"
        case .info:
            return "INFO"
        case .error:
            return "ERROR"
        }
    }
    var tag: String {
        switch self {
        case .debug:
            return "D"
        case .info:
            return "I"
        case .error:
            return "E"
        }
    }
    
    var osType: OSLogType {
        switch self {
        case .debug:
            return OSLogType.debug
        case .info:
            return OSLogType.info
        case .error:
            return OSLogType.error
        }
    }
}
