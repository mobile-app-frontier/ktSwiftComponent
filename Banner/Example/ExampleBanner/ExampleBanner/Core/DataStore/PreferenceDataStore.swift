//
//  PreferenceDataStore.swift
//  ExampleBanner
//
//  Created by 이소정 on 2023/08/24.
//

import Foundation
import Banner

struct PreferenceDataStore {
    
    private struct Keys {
        static let localBannerPolicy = "preferences.localBannerPolicy"
    }
    
    
    /// local banner policy
    static var localBannerPolicy: LocalBannerPolicy? {
        get {
            if let data = UserDefaults.standard.data(forKey: Keys.localBannerPolicy) {
                return try? PropertyListDecoder().decode(LocalBannerPolicy.self, from: data)
            }
            return nil
        }
        set {
            if let encodedData = try? PropertyListEncoder().encode(newValue) {
                UserDefaults.standard.set(encodedData, forKey: Keys.localBannerPolicy)
                UserDefaults.standard.synchronize()
            }
        }
    }
    
}
