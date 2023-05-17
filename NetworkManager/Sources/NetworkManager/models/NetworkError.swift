//
//  NetworkError.swift
//  GeniePhone
//
//  Created by pjx on 2023/02/15.
//

import Foundation

public protocol NetworkError: Error {}

//MARK: - Restful Network Error
public enum NetworkRestfulError: NetworkError {
//    public var description: String {
//        switch self {
//        case .parsingError(let error):
//            return buildDescription(name: "invalid params in server return \(error.localizedDescription)")
//        case .serverError(let networkError, let rawError):
//            return buildDescription(
//                name: "server error [code: \(String(describing: networkError.code)), msg:\(String(describing: networkError.msg)), raw: \(rawError?.localizedDescription ?? "")]")
//        case .timeoutError(let error, let url):
//            return buildDescription(name: "server Time-out (\(url) \(error.localizedDescription)")
//        case .canceled(let url):
//            return buildDescription(name: "requset is canceled (\(url))")
//        }
//    }
    
    /// parsing error
    case parsingError(rawError: Error)
    case timeoutError(rawError: Error, url: String)
    /// network error
    case serverError(networkError: NetworkResponseError, rawError: Error?)
    case canceled(url:String)
    case invalidCancelerToken
}
/// normal error code
/// 1xx : info
/// 2xx : success
/// 3xx : redirection
/// 4xx: client error
/// 5xx: server error
///
public struct NetworkResponseError : Error{
    let code: Int?
    let msg: String?
}

//MARK: - NetworkDownload Error
public enum NetworkDownloadError: NetworkError {
//    public var description: String {
//        switch self {
//        case .downloadStateError:
//            return buildDescription(name: "task is already canceled")
//        case .serverError(let networkError, let rawError):
//            return buildDescription(
//                name: "server error [code: \(String(describing: networkError.code)), msg:\(String(describing: networkError.msg)), raw: \(rawError.localizedDescription)]")
//        case .failToMakeRequest(let url):
//            return buildDescription(name: "fail to make request \(url)")
//        }
//    }
    
    
    case downloadStateError
    case failToMakeRequest(url: String)
    case serverError(networkError: NetworkResponseError, rawError:Error)
}

