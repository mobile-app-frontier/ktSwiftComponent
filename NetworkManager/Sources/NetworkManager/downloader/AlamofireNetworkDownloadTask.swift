//
//  NetworkDownloadTask.swift
//  GeniePhone
//
//  Created by pjx on 2023/02/15.
//
    
import Foundation
import Alamofire

class AlamofireNetworkDownloadTask {
    
    let session: Session
    
    let url: String
    
    let destinationPath: String
    
    @Published var internalDownloadState: NetworkDownloadState = .initialState
    
    @Published var internalDownloadProgress: Progress = Progress()
    
    var prevDownloadedData: Data?
    
    var request: DownloadRequest? 
    
    var downloadState: Published<NetworkDownloadState>.Publisher { $internalDownloadState }
    
    var downloadProgress: Published<Progress>.Publisher { $internalDownloadProgress }

    
    init(session: Session,
         url: String,
         destinationPath: String,
         prevDownloadedData: Data? = nil
    ) {
        self.session = session
        self.url = url
        self.destinationPath = destinationPath
        self.prevDownloadedData = prevDownloadedData
    }
}

