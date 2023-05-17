//
//  AlamofireNetworkDownloadTask+DownloadTask.swift
//  GeniePhone
//
//  Created by pjx on 2023/02/16.
//

import Foundation
import Alamofire
import SwiftUI



//MARK: - NetworkDownloadTask
extension AlamofireNetworkDownloadTask: NetworkDownloadTask {
 
    public func prepareTask() {
        if let prevDownloadedData = prevDownloadedData {
            self.request = session.download(resumingWith: prevDownloadedData, to: createDestination())
        } else {
            self.request = session.download(url, to: createDestination())
        }
        
        guard let request = self.request else {
            debugPrint("[Network] \(url) : failToMakeRequest")
            return
        }
        
        request.downloadProgress(closure: { [weak self] progress in
            self?.updateProgress(progress: progress)
        })
        .response { [weak self] response in
            self?.prevDownloadedData = response.resumeData
            if let error = response.error {
                let downloadError = NetworkDownloadError.serverError(
                    networkError: error.toNetworkError(),
                    rawError: error
                )
                
                /// update state
                self?.updateState(state: .canceled(error: downloadError))
            }
        }
        
        updateState(state: .ready)
    }
    
    public func suspend() {
        self.request?.suspend()
        updateState(state: .suspended)
    }
    
    public func resume() {
        if case .canceled = self.internalDownloadState {
            debugPrint("[Network] \(url) : downloadStateError")
            return
        }
        
        self.request?.resume()
        updateState(state: .downloading)
    }
    
    public func cancel() {
        prevDownloadedData = self.request?.cancel(producingResumeData: true).resumeData
        updateState(state: .canceled(error: nil))
    }
}


extension AlamofireNetworkDownloadTask {
    
    private func createDestination() -> DownloadRequest.Destination {
        let destination: DownloadRequest.Destination = { [destinationPath] _, response in
            let fileURL = URL(fileURLWithPath: destinationPath)
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        return destination
    }
    
    /// update state
    private func updateState(state: NetworkDownloadState) {
        Task {
            await MainActor.run(body: {
                self.internalDownloadState = state
            })
        }
    }
    
    func updateProgress(progress: Progress) {
        Task {
            await MainActor.run(body: {
                self.internalDownloadProgress = progress
            })
        }
    }
    
    
}
