//
//  BannerPolicyRepository.swift
//  GeniePhone
//
//  Created by 이소정 on 2023/04/10.
//

import Foundation

public protocol BannerPolicyRepository {
    func getBannerPolicy() async throws -> BannerPolicy
}

public final class MockBannerPolicyRepository: BannerPolicyRepository {
    public init() {}
    
    public let dataSource = MockBannerPolicyDataSource()
    
    public func getBannerPolicy() async throws -> BannerPolicy {
        let model = try await dataSource.getBannerPolicy()
        
        return BannerPolicy(from: model)
    }
}
