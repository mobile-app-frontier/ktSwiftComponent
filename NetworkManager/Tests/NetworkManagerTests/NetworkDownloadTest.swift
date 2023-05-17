//
//  File.swift
//  
//
//  Created by pjx on 2023/04/01.
//

import XCTest
@testable import NetworkManager

final class NetworkDownloadTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDownload() throws {
        let task = NetworkManager.instance.downdloadTask("url", destinationPath: "path", prevData: nil)
        
        _ = task.downloadState.sink { state in
            debugPrint("download state : \(state)")
        }
        
        _ = task.downloadProgress.sink { progress in
            debugPrint("download state : \(progress.completedUnitCount)/\(progress.totalUnitCount)")
        }
        
        /// prepare
        task.prepareTask()
        
        /// start
        task.resume()
    }
    
    func testDownloadCancel() throws {
        let task = NetworkManager.instance.downdloadTask("url", destinationPath: "path", prevData: nil)
        
        _ = task.downloadState.sink { state in
            debugPrint("download state : \(state)")
        }
        
        _ = task.downloadProgress.sink { progress in
            debugPrint("download state : \(progress.completedUnitCount)/\(progress.totalUnitCount)")
        }
        
        /// prepare
        task.prepareTask()
        
        /// start
        task.resume()
        
        /// cancel
        task.cancel()
    }
    
    func testDownloadSuspend() throws {
        let task = NetworkManager.instance.downdloadTask("url", destinationPath: "path", prevData: nil)
        
        _ = task.downloadState.sink { state in
            debugPrint("download state : \(state)")
        }
        
        _ = task.downloadProgress.sink { progress in
            debugPrint("download state : \(progress.completedUnitCount)/\(progress.totalUnitCount)")
        }
        
        /// prepare
        task.prepareTask()
        
        /// start
        task.resume()
        
        /// cancel
        task.suspend()
    }
    
    func testDownloadCancelNResume() throws {
        let task = NetworkManager.instance.downdloadTask("url", destinationPath: "path", prevData: nil)
        
        _ = task.downloadState.sink { state in
            debugPrint("download state : \(state)")
        }
        
        _ = task.downloadProgress.sink { progress in
            debugPrint("download state : \(progress.completedUnitCount)/\(progress.totalUnitCount)")
        }
        
        /// prepare
        task.prepareTask()
        
        /// start
        task.resume()
        
        /// cancel
        task.cancel()
        
        /// prepare
        task.prepareTask()
        
        /// resume
        task.resume()
    }

}
