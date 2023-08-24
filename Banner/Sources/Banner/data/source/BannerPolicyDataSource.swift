//
//  BannerPolicyDataSource.swift
//  GeniePhone
//
//  Created by 이소정 on 2023/04/10.
//

import Foundation



/// Banner Policy 를 서버에서 받아올 때 사용되는 DataSource Protocol
public protocol BannerPolicyDataSource {
    /// 서버에서 받아온 BannerPolicy Json 정보를 `[BannerPolicyItemModel]` 로 변환하여 return
    /// - Returns: 서버에서 받아온 Banner Policy Item 들의 List
    func getBannerPolicy() async throws -> [BannerPolicyItemModel]
}

/// Banner Policy 참고용 Mock Data
public final class MockBannerPolicyDataSource: BannerPolicyDataSource {
    public init() {}
    
    /// 1 초 delay 후, 미리 정의한 Mock Data 를 return 해줌. 테스트 할 때만 사용할 것
    /// - Returns: Banner Policy Mock Data
    public func getBannerPolicy() async throws -> [BannerPolicyItemModel] {
        // delay 1 sec
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        
        let jsonData = """
            [
                {
                    "id": "01",
                    "priority": 3,
                    "contentType": "I",
                    "content": "https://fastly.picsum.photos/id/668/500/100.jpg?hmac=_H_udLJmfNoUADzswUtbwREyM_Gi8FhAfJam4K4eeBs",
                    "landingType": "callHistory",
                    "appVersion": "1.0.0",
                    "category": "callHistory",
                    "type": "default"
                },
                {
                    "id": "02",
                    "priority": 1,
                    "contentType": "I",
                    "content": "https://fastly.picsum.photos/id/1060/500/100.jpg?hmac=tznkBFjqCQH43p5Aju0y6svIB5NeZJNy97suMtDgPyA",
                    "landingType": "callHistory",
                    "appVersion": "1.0.0",
                    "category": "callHistory",
                    "type": "default"
                },
                {
                    "id": "03",
                    "priority": 2,
                    "contentType": "I",
                    "content": "https://fastly.picsum.photos/id/679/500/100.jpg?hmac=lcSPbarTaBAgoeC3ye9rsJpg2H_A3moc2UKU33QyAh8",
                    "appVersion": "1.0.0",
                    "category": "callHistory",
                    "type": "default"
                },
                {
                    "id": "04",
                    "priority": 1,
                    "contentType": "T",
                    "content": "공지사항 배너 테스트",
                    "appVersion": "1.0.0",
                    "landingType": "contact",
                    "closeType": "never",
                    "type": "popup"
                },
                {
                    "id": "05",
                    "priority": 4,
                    "contentType": "T",
                    "content": "테스트.........",
                    "appVersion": "1.0.0",
                    "landingType": "contact",
                    "closeType": "never",
                    "type": "popup"
                },
                {
                    "id": "06",
                    "priority": 8,
                    "contentType": "H",
                    "content": "<h1>Hello, <strong>World!</strong></h1>",
                    "appVersion": "1.0.0",
                    "landingType": "none",
                    "closeType": "week",
                    "type": "popup"
                },
                {
                    "id": "07",
                    "priority": 2,
                    "contentType": "I",
                    "content": "https://fastly.picsum.photos/id/565/1000/600.jpg?hmac=oJQa8_RLVzpyhJggqcyNnMUelPH8nqYUaqj65ws0p5c",
                    "appVersion": "1.0.0",
                    "landingType": "callHistory",
                    "closeType": "today",
                    "type": "popup"
                },
                {
                    "id": "08",
                    "priority": 10,
                    "contentType": "H",
                    "content": "<style> p {text-align: left;}</style><p><strong>업데이트가 완료 되었습니다.<br></strong></p><p><strong>정기휴무일 '주차' ➔ '번째'로 변경 안내</strong></p><p>정기휴무일 설정 단위를 좀더 명확하게 개선하였습니다.</p><p>고객님들께서는 휴무일 순서가 변경되진 않았는지 확인 부탁 드립니다.</p><p>자세한 사항은 공지사항을 참고해주세요!</p><p>※ 설정 방법:</p><p>설정 &gt; 정보관리 &gt; 영업시간 및 휴일</p>",
                    "appVersion": "1.0.0",
                    "landingType": "web",
                    "landingDestination": "https://docs.swift.org/",
                    "closeType": "never",
                    "type": "popup"
                }

            ]
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        
        let banners = try decoder.decode([BannerPolicyItemModel].self, from: jsonData)
        
        return banners
    }
    
}
