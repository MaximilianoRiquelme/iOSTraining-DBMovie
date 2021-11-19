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
        
        mockNetworkingManager.success =  true
        
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
        
        self.waitForExpectations(timeout: 0.5, handler: nil)
    }
    
    func testLoadTopRatedFailure() {
        let expectation = self.expectation(description: "Expectation")
        
        mockNetworkingManager.success = false
        
        sut.loadTopRated(page: 1) { result in
            switch result {
            case .success(_):
                XCTFail("Expected failure instead.")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 0.2, handler: nil)
    }
}

class MockNetworkingManager: NetworkingManagerProtocol {
    
    var success = true
    
    func getData(url: URL, completion: @escaping NetworkingResult) {
        if success {
            completion(.success(Data()))
        }
        else {
            completion(.failure(MockError()))
        }
    }
}

struct MockError: Error {
    
}
