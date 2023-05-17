//
//  NetworkDownloadModels.swift
//  GeniePhone
//
//  Created by pjx on 2023/02/15.
//

import Foundation

/// downdload state
public enum NetworkDownloadState {
    case initialState
    case ready
    case downloading
    case suspended
    case canceled(error: NetworkDownloadError?)
}
