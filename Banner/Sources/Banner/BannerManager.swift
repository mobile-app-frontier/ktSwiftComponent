//
//  BannerManager.swift
//  GeniePhone
//
//  Created by 이소정 on 2023/04/11.
//

import Foundation
import Combine
import SwiftUI

/// `PopupBanner` 를 보여주는 `Sheet View` 관리와 `category` 별 `DefaultBannerView` 를 제공해주는 기능을 함.
public final class BannerManager {
    /// `BannerManager` 의 Singleton Instance
    public static let instance = BannerManager()
    
    /// `isInitialized`: BannerManager initialize 여부. initialize 는 한번만 가능.
    private var isInitialized = false
    
    /// `bannerPolicy`: BannerManager 에서 Handling 할 BannerPolicy. BannerManager 는 해당 bannerPolicy 기반으로 동작됨.
    private var bannerPolicy: BannerPolicy?
    
    /// Landing
    /// `landingSubject`: BannerManager 에서 내부적으로 들고 있는 landing subject.
    private let landingSubject = PassthroughSubject<BannerLandingType, Never>()
    
    /// 외부에서 사용자 interaction 에 의한 `Banner` Landing  화면을 구독할 수 있는 Publisher.
    ///
    /// ex) 사용자가 `LandingType` 이 있는 `DefaultBannerView` 혹은 `PopupBannerView` 를
    /// tap 했을 때 Publish 될 수 있음.
    public var landingPublisher: AnyPublisher<BannerLandingType, Never> {
        landingSubject.eraseToAnyPublisher()
    }
    // Banner Package 내부에서 landing event 가 발생할 때 호출하는 function.
    internal func send(landingType: BannerLandingType) {
        landingSubject.send(landingType)
    }
    
    /// LocalBannerPolicy
    /// `localBannerPolicyGetter`: 외부에서 injection 받은 단말에 저장되어 있는 LocalBannerPolicy 를 read 하는 function.
    private var localBannerPolicyGetter: (() async -> LocalBannerPolicy)?
    /// `localBannerPolicySetter`: 외부에서 injection 받은 변경된 LocalBannerPolicy 를 단말에 write 하는 function.
    private var localBannerPolicySetter: ((LocalBannerPolicy) async -> Void)?
    /// `localBannerPolicy`: 단말에 저장되어 있는 LocalBannerPolicy + 새로 추가된 로컬 정책.(Popup banner 가 닫힐 때마다 새로운 정책이 추가될 수 있음.)
    private var localBannerPolicy: LocalBannerPolicy = [:]
    
    /// Routing
    /// `present`: 외부에서 injection 받은 PopupBanner present function. (SwiftUI 의 경우, navigation 이 version 별로 분기처리되어 있어 App 에서 customize 할 수 있도록 injection 받음.)
    private var present: ((PopupBannerPolicyItem) -> Void)?
    /// `dismiss`: 외부에서 injection 받은 PopupBanner dismiss function. (SwiftUI 의 경우, navigation 이 version 별로 분기처리되어 있어 App 에서 customize 할 수 있도록 injection 받음.)
    private var dismiss: (() -> Void)?
    
    /// Popup
    /// `willShowPopupBannerPolicy`: 보여줄 Popup Banner Policy. PriorityQueue 이므로 이미 보여준 배너는 없음.
    private var willShowPopupBannerPolicy = PopupBannerPolicy()

    private init() {}
    
    
    // BannerManager initializer.
    // BannerManager 는 Singleton 이므로, injection 해줘야 하는 Data 들을 해당 function 호출을 통해 지정함.
    // 해당 function 은 BannerManager 사용전에 반드시 호출되어야 하며, 한번만 호출이 가능함. (이미 initialize 를 진행했다면 새로운 parameter 는 setting 되지 않음.)
    internal func initialize(bannerPolicy: BannerPolicy?,
                             localBannerPolicyGetter: @escaping () async -> [String : Int],
                             localBannerPolicySetter: @escaping ([String : Int]) async -> Void
    ) {
        guard !isInitialized else {
            debugPrint("[BannerPolicy] BannerManager 는 initialize 되어 있습니다.")
            return
        }
        
        isInitialized = true
        
        self.bannerPolicy = bannerPolicy
        self.localBannerPolicyGetter = localBannerPolicyGetter
        self.localBannerPolicySetter = localBannerPolicySetter
    }
    
    
    /// category 에 해당하는 `DefaultBanner` image 들을 ImageSlider 형태의 View 로 제공해줌.
    ///
    /// - Parameter category:`DefaultBanner` 의 category
    /// - Returns: 입력받은 category 에 맞는 `DefaultBannerView`. 해당 category 에 일치하는 banner 가 없을 경우, nil 을 return 함.
    public func buildDefaultBannerView(category: String) -> DefaultBannerView? {
        guard isInitialized else {
            debugPrint("[BannerPolicy] BannerManager 를 initialze 한 후에 사용하세요.")
            return nil
        }
        guard let defaultBanners = bannerPolicy?.defaultBanner[category], !defaultBanners.isEmpty else {
            debugPrint("[BannerPolicy] 해당 category: \(category) 의 banner 가 없습니다.")
            return nil
        }
        return DefaultBannerView(defaultBanners: defaultBanners)
    }
    
    // PopupBanner sheet 를 start 해줌.
    // 내부에서 처음 initialize 에 입력받은 BannerPolicy 의 popupBanner 을 다시 세팅해주므로,
    // start() 를 다시 호출할 경우, bannerPolicy.popupBanner 을 처음부터 다시 보여줌.
    /// `PopupBanner` sheet 를 start
    ///
    /// `PopupBanner` 들이 하나씩 `Sheet` 로 보여짐.
    ///
    /// - Important: `PopupBanner` 가 보여지고 있는 상태에서는 다시 호출하면 안됨. 또한, 모든 `PopupBanner` 를 전부 보여준 후 다시 call 할 경우 `BannerPolicyFetcher` 에서 fetch 한 배너들이 다시 처음부터 보여짐.
    ///
    /// - Parameters:
    ///   - present: `PopupBannerPolicyItem` 받아 생성한 `PopupBannerView` 를 present 하는 로직.
    ///   - dismiss: App navigator 에서 sheet 를 dismiss 하는 로직.
    public func start(present: @escaping (PopupBannerPolicyItem) -> Void,
                      dismiss: @escaping () -> Void) {
        guard isInitialized else {
            debugPrint("[BannerPolicy] BannerManager 를 initialze 한 후에 사용하세요.")
            return
        }
        
        guard let bannerPolicy = bannerPolicy else {
            debugPrint("[BannerPolicy] banner policy 가 없습니다.")
            return
        }
        
        self.present = present
        self.dismiss = dismiss
        
        Task {
            localBannerPolicy = await localBannerPolicyGetter!()
            
            willShowPopupBannerPolicy = bannerPolicy.popup
            presentPopup()
        }
    }
    
    // 보여줄 popup banner 중 높은 우선순위의 popup banner 을 present 함.
    private func presentPopup() {
        if (!willShowPopupBannerPolicy.isEmpty) {
            let popupBanner = willShowPopupBannerPolicy.pop()!
            
            Task {
                await MainActor.run {
                    present?(popupBanner)
                }
            }
        }
    }
    
    // 현재 열려있는 popup banner 를 닫은 후, 보여줄 popup banner 있다면 present 함.
    // id 와 notShowedDate 를 parameter 로 입력할 경우, 해당 id 의 배너를 보여주지 않을 기간을 localBannerPolicy 에 추가하여
    // 단말에 저장한 후, popup banner 을 닫고 새로운 popup banner 를 보여줌.
    internal func dismissAndPresentPopup(id: String? = nil, notShowedDate: Date? = nil) {
        Task {
            // 닫을 때마다, local banner 저장.
            if let id = id, let notShowedDate = notShowedDate {
                await saveLocalBannerPolicy(id: id, notShowedDate: notShowedDate)
            }
            
            await MainActor.run {
                dismiss?()
                presentPopup()
            }
        }
    }
    
    // parameter 로 받은 id 의 보여주지 않을 기간을 local banner policy 에 추가한 이후, 단말에 저장함.
    private func saveLocalBannerPolicy(id: String, notShowedDate: Date) async {
        localBannerPolicy[id] = Int(notShowedDate.timeIntervalSince1970)
        
        await localBannerPolicySetter?(localBannerPolicy)
    }

}
