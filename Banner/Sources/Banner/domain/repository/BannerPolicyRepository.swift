//
//  BannerPolicyRepository.swift
//  GeniePhone
//
//  Created by 이소정 on 2023/04/10.
//

import Foundation

internal final class BannerPolicyRepository {
    internal let dataSource: BannerPolicyDataSource
    
    internal init(dataSource: BannerPolicyDataSource) {
        self.dataSource = dataSource
    }
    
    internal func getBannerPolicy() async throws -> BannerPolicy {
        let model = try await dataSource.getBannerPolicy()
        
        return BannerPolicy(from: model)
    }
}

