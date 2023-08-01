//
//  NetworkRequestModels.swift
//  GeniePhone
//
//  Created by pjx on 2023/02/15.
//

import Foundation

/// Network method
public enum NetworkMethod {
    case get
    case post
    case patch
    case put
    case delete
}

public enum NetworkRequestEncoding {
    case url
    case json
}

public struct NetworkRequest {
    let method: NetworkMethod
    let header: [String: String]
    let params: [String: Any]?
    let encoding: NetworkRequestEncoding
    
    public init(method: NetworkMethod = .get, header: [String : String] = [:], params: [String : Any]?, encoding: NetworkRequestEncoding = .url) {
        self.method = method
        self.header = header
        self.params = params
        self.encoding = encoding
    }
    
    public init(method: NetworkMethod = .get, header: [String : String] = [:], params: [String : Any]?) {
        self.method = method
        self.header = header
        self.params = params
        self.encoding = .url
    }
}

public struct NetworkCancelToken : Hashable{}
