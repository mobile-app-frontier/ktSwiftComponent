import XCTest
@testable import NetworkManager

final class NetworkManagerTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testRestfulApi() async throws  {
        let test = await NetworkManager.instance.request("https://swapi.dev/api/films", type: TestFilms.self, method: .get)
        
        switch (test) {
        case .success(_):
            print("success")
        case .failure(let error):
            print("error : \(error)")
        }
    }
    
    func testInvalidUrlApi() async throws {
        let test = await NetworkManager.instance.request("https://dev/api/films", type: TestFilms.self, method: .get)

        switch (test) {
        case .success(_):
            XCTAssert(
                false,
                "request is invalid server url"
            )
        case .failure(let error):
            print("error : \(error)")
        }
    }
    
    func testParsingError() async throws {
        let test = await NetworkManager.instance.request("https://swapi.dev/api/films", type: TestFilm.self, method: .get)
        
        switch (test) {
        case .success(_):
            XCTAssert(
                false,
                "Type matching error"
            )
        case .failure(let error):
            print("error : \(error)")
        }
    }
    
    func testTimeOut() async throws {
        let test = await NetworkManager.instance.request("http://192.168.0.1/", type: TestFilm.self, method: .get)
        
        switch (test) {
        case .success(_):
            XCTAssert(
                false,
                "Type matching error"
            )
        case .failure(let error):
            print("error : \(error)")
        }
    }
    
    func testCancelRequest() async throws {
        let cancelToken: NetworkCancelToken = NetworkCancelToken()
        
        /// Network Call Task
        Task {
            let test = await NetworkManager.instance.request("http://192.168.0.1/", type: TestFilm.self, method: .get, cancelToken: cancelToken)
            
            switch (test) {
            case .success(_):
                XCTAssert(
                    false,
                    "Type matching error"
                )
            case .failure(let error):
                print("error : \(error)")
            }
        }
        
        /// cancel task
        try await Task.sleep(nanoseconds:1_000_000_000 * 2)
        NetworkManager.instance.cancelRequest(cancelToken: cancelToken)
    }

}




/// test models
struct TestFilms: Codable {
  let count: Int
  let all: [TestFilm]
  
  enum CodingKeys: String, CodingKey {
    case count
    case all = "results"
  }
}

struct TestFilm: Codable {
  let id: Int
  let title: String
  let openingCrawl: String
  let director: String
  let producer: String
  let releaseDate: String
  let starships: [String]
  
  enum CodingKeys: String, CodingKey {
    case id = "episode_id"
    case title
    case openingCrawl = "opening_crawl"
    case director
    case producer
    case releaseDate = "release_date"
    case starships
  }
}
