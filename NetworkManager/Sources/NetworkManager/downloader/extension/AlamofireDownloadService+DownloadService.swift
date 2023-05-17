//
//  AlamofireDownloadService+DownloadService.swift
//  GeniePhone
//
//  Created by pjx on 2023/02/15.
//

import Foundation
import Alamofire


extension AlamofireDownloadService: DownloadService {
    func downloadTask(_ url:String,
                      destinationPath: String,
                      prevData:Data?
    ) -> NetworkDownloadTask {
        return AlamofireNetworkDownloadTask(session: downloadSession,
                                            url: url,
                                            destinationPath: destinationPath,
                                            prevDownloadedData: prevData
        )
    }
}
