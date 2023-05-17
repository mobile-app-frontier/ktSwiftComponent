//
//  DownloadService.swift
//  GeniePhone
//
//  Created by pjx on 2023/02/15.
//

import Foundation
import Alamofire


class AlamofireDownloadService {
    public let downloadSession: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        return Session(configuration: configuration)
    }()
}
