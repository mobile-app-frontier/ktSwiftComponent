//
//  NetworkRequestInterceptor.swift
//  GeniePhone
//
//  Created by 박주철 on 2023/02/12.
//

import Foundation
import Alamofire

public protocol NetworkRequestInterceptor {
    
    ///
    /// token refresh중 다른 api들이 들어왔을때 들어온 api들에 대한 suspend를 할 수 있어야 한다.
    /// waiting condition이 있어야 한다...
    ///
    func preprocessor(request:NetworkRequest) async -> NetworkRequest
    
}

public protocol NetworkResponseInterceptor {
    func postDataProcessor(data: Data) -> Data
}
