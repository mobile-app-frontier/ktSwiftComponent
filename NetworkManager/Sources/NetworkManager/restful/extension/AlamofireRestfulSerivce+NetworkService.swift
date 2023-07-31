//
//  AlamofireService+NetworkService.swift
//  GeniePhone
//
//  Created by pjx on 2023/02/13.
//
import Foundation
import Alamofire

//MARK: - NetworkService
extension AlamofireRestfulService: RestfulService {
    func cancelTask(canceler: NetworkCancelToken) {
        if let cancelTask = requestMap.removeValue(forKey: canceler){
            cancelTask.cancel()
        }
    }
    
    
    
    /// response modeling
    func request<T>(_ url: String,
                    type: T.Type,
                    request: NetworkRequest,
                    canceler: NetworkCancelToken?,
                    requestInterceptor: NetworkRequestInterceptor?,
                    responseInterceptor: NetworkResponseInterceptor?
    ) async -> Result<T, NetworkRestfulError> where T : Codable {
        let result = await self.request(url,
                                        request: request,
                                        canceler: canceler,
                                        requestInterceptor: requestInterceptor,
                                        responseInterceptor: responseInterceptor
        )
        
        switch result {
        case .success(let data):
            return convert(type: T.self, data: data)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    /// response raw data format
    ///
    func request(_ url: String,
                 request: NetworkRequest,
                 canceler:NetworkCancelToken?,
                 requestInterceptor: NetworkRequestInterceptor?,
                 responseInterceptor: NetworkResponseInterceptor?
    ) async -> Result<Data, NetworkRestfulError> {
        
        let requestTask: DataRequest
        
        switch requestInterceptor {
            /// if intercepter is alamofire protocol
            /// set alamofire interceptor
        case let requestInterceptor as AlamofireNetworkRequestInterceptor:
            requestTask = networkSession.request(url,
                                                 method: request.method.toHttpMethod(),
                                                 parameters: request.params,
                                                 headers: HTTPHeaders(request.header),
                                                 interceptor: requestInterceptor
            )
            break
        default:
            var preprocessedRequest:NetworkRequest
            if let task = await requestInterceptor?.preprocessor(request: request) {
                preprocessedRequest = task
            } else {
                preprocessedRequest = request
            }
            
            requestTask = networkSession.request(url,
                                                 method: preprocessedRequest.method.toHttpMethod(),
                                                 parameters: request.params,
                                                 headers: HTTPHeaders(preprocessedRequest.header)
            )
            break
        }
        
        
        
        if let canceler = canceler {
            requestMap[canceler] = requestTask
        }
        
        let result = await requestTask.serializingData()
            .response
            .result
        
        /// remove request in map
        if let canceler = canceler {
            requestMap.removeValue(forKey: canceler)
        }
        
        switch result {
        case .success(let data):
            if let responseInterceptor = responseInterceptor {
                return .success(responseInterceptor.postDataProcessor(data: data))
            }
            return .success(data)
        case .failure(let error):
            
            
            if error._code == NSURLErrorTimedOut {
                debugPrint("[Network] timeoutError : \(url)")
                
                return .failure(.timeoutError(rawError: error, url: url))
            } else {
                if error.isExplicitlyCancelledError {
                    return .failure(.canceled(url: url))
                } else {
                    debugPrint("[Network] serverError : \(error)")
                    
                    return .failure(.serverError(networkError: error.toNetworkError(),
                                                 rawError: error))

                }
            }
            
        }
    }
}



//MARK: - utils
extension AlamofireRestfulService {
    private func convert<T>(type: T.Type,
                            data: Data
    ) -> Result<T, NetworkRestfulError> where T: Codable {
        
        do {
            let decoder = JSONDecoder()
            return .success(try decoder.decode(T.self, from: data))
        } catch {
            debugPrint("[Error] [\(type)] parsingError")
            return .failure(NetworkRestfulError.parsingError(rawError: error))
        }
    }
}
