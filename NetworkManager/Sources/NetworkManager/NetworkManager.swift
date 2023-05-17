//
//  NetworkManager.swift
//  i recoding dialer
//
//  Created by pjx on 2023/02/01.
//

import Foundation
import Alamofire


public struct NetworkManager {
    public static let instance = NetworkManager()
    
    
    private let restfulService: RestfulService = {
        return AlamofireRestfulService()
    }()
    
    private let downloadService: DownloadService = {
        return AlamofireDownloadService()
    }()
    
    private let websocketService: WebSocketService = {
        return NetworkWebSocketService()
    }()
}


// MARK: - HttpService
extension NetworkManager {
    public func request<T> (_ url:String,
                            type: T.Type,
                            method: NetworkMethod,
                            header: [String: String] = [:],
                            param: [String: Any] = [:],
                            cancelToken: NetworkCancelToken? = nil,
                            requestInterceptor: NetworkRequestInterceptor? = nil,
                            responseInterceptor: NetworkResponseInterceptor? = nil
    ) async -> Result<T, NetworkRestfulError> where T : Codable {
        return await restfulService.request(url,
                                            type: T.self,
                                            request: NetworkRequest(method: method, header: header, params: param),
                                            canceler: cancelToken,
                                            requestInterceptor: requestInterceptor,
                                            responseInterceptor: responseInterceptor
        )
    }
    
    public func request(_ url:String,
                        method: NetworkMethod,
                        header: [String: String] = [:],
                        param: [String: Any] = [:],
                        cancelToken: NetworkCancelToken? = nil,
                        requestInterceptor: NetworkRequestInterceptor? = nil,
                        responseInterceptor: NetworkResponseInterceptor? = nil
    ) async -> Result<Data, NetworkRestfulError>{
        return await restfulService.request(url,
                                            request: NetworkRequest(method: method, header: header, params: param),
                                            canceler: cancelToken,
                                            requestInterceptor: requestInterceptor,
                                            responseInterceptor: responseInterceptor
        )
    }
    
    public func cancelRequest(cancelToken: NetworkCancelToken) {
        restfulService.cancelTask(canceler: cancelToken)
    }
    
}


//MARK: - Download Service
extension NetworkManager {
    public func downdloadTask(_ url:String,
                              destinationPath: String,
                              prevData: Data?
    ) -> NetworkDownloadTask{
        return downloadService.downloadTask(url,
                                            destinationPath: destinationPath,
                                            prevData: prevData
        )
    }
}
