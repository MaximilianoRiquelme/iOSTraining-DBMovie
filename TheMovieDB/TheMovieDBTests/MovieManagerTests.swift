//
//  TheMovieDBTests.swift
//  TheMovieDBTests
//
//  Created by Jaime Laino on 8/2/21.
//

import XCTest
@testable import TheMovieDB

class MovieManagerTests: XCTestCase {
    
    private var sut: MovieManager!
    private var mockNetworkingManager: MockNetworkingManager!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockNetworkingManager = MockNetworkingManager()
        sut = MovieManager(networkingController: mockNetworkingManager)
    }

    override func tearDownWithError() throws {
        mockNetworkingManager = nil
        sut = nil
        try super.tearDownWithError()
    }

    func testLoadTopRatedSuccess() {
        let expectation = self.expectation(description: "Expectation")
        
        sut.loadTopRated(page: 1) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let topRatedList):
                    XCTAssertNotNil(topRatedList)
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
                expectation.fulfill()
            }
        }
        
        self.waitForExpectations(timeout: 60, handler: nil)
    }
    
    func testLoadTopRatedFailure() {
        let expectation = self.expectation(description: "Expectation")
        
        mockNetworkingManager.success = false
        
        sut.loadTopRated(page: 1) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    XCTFail("Expected failure instead.")
                case .failure(let error):
                    XCTAssertNotNil(error)
                }
                expectation.fulfill()
            }
        }
        
        self.waitForExpectations(timeout: 60, handler: nil)
    }
}

class MockNetworkingManager: NetworkingManagerProtocol {
    
    var success = true
    var jsonName: String?
    
    func getData(url: URL, completion: @escaping NetworkingResult) {
        if self.success {
            DispatchQueue.global(qos: .background).async {
                if let filePath = Bundle.main.url(forResource: "top_rated", withExtension: "json") {
                        do {
                        //let fileUrl = URL(fileURLWithPath: filePath)
                        let data = try Data(contentsOf: filePath)
                        completion(.success(data))
                        } catch {
                            completion(.failure(NetworkingError.serverError))
                        }
                }
                else {
                    completion(.failure(NetworkingError.serverError))
                }
            }
        }
        else {
            completion(.failure(MockError()))
        }
    }
}

struct MockError: Error {
    
}
