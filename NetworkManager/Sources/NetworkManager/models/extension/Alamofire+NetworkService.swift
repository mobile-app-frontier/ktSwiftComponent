//
//  Alamofire+NetworkService.swift
//  GeniePhone
//
//  Created by pjx on 2023/02/20.
//

import Foundation
import Alamofire

extension NetworkMethod {
    func toHttpMethod () -> HTTPMethod {
        switch(self) {
        case .delete:
            return .delete
        case .get:
            return .get
        case .patch:
            return .patch
        case .post:
            return .post
        case .put:
            return .put
        }
    }
}

//MARK: AFError To Defined Network error
extension AFError {
    func toNetworkError() -> NetworkResponseError {
        return NetworkResponseError(code: self.responseCode, msg: self.errorDescription)
    }
}
