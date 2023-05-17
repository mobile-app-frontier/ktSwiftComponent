//
//  NetworkService.swift
//  GeniePhone
//
//  Created by 박주철 on 2023/02/12.
//

import Foundation

//MARK: ** Restful Service **

public protocol RestfulService {
    func request<T>(_ url: String,
                    type: T.Type,
                    request: NetworkRequest,
                    canceler:NetworkCancelToken?,
                    requestInterceptor: NetworkRequestInterceptor?,
                    responseInterceptor: NetworkResponseInterceptor?
    ) async -> Result<T, NetworkRestfulError> where T: Codable
    
    func request(_ url: String,
                 request: NetworkRequest,
                 canceler:NetworkCancelToken?,
                 requestInterceptor: NetworkRequestInterceptor?,
                 responseInterceptor: NetworkResponseInterceptor?
    ) async -> Result<Data, NetworkRestfulError>
    
    func cancelTask(canceler: NetworkCancelToken)
}



//MARK: ** Download Service **
public protocol NetworkDownloadTask {
    var downloadState: Published<NetworkDownloadState>.Publisher { get }
    
    var downloadProgress: Published<Progress>.Publisher { get }
    
    func prepareTask()
    
    func suspend()
    
    func resume()
    
    func cancel()
}

protocol DownloadService {
    
    func downloadTask(_ url: String,
                      destinationPath:String,
                      prevData:Data?
    ) -> NetworkDownloadTask
}


//MARK: ** Websocket Service **

public protocol WebSocketService {
    var receiveData: Published<Data>.Publisher { get }
    
    var connectState: Published<NetworkWebSocketConnectState>.Publisher { get }
    
    func connect(url: URL)
    
    func send(data: Data)
}

