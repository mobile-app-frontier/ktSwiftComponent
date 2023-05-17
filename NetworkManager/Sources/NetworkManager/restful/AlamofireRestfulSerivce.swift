//
//  AlamofireSerivce.swift
//  GeniePhone
//
//  Created by 박주철 on 2023/02/12.
//

import Foundation
import Alamofire


class AlamofireRestfulService {
    public let networkSession: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        return Session(configuration: configuration)
      }()
    
    
    var requestMap: [NetworkCancelToken:DataRequest] = [:]
}


