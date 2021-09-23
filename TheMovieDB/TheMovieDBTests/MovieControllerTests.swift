//
//  TheMovieDBTests.swift
//  TheMovieDBTests
//
//  Created by Jaime Laino on 8/2/21.
//

import XCTest
@testable import TheMovieDB

class MovieControllerTests: XCTestCase {
    
    var systemUnderTest: MovieControllerImplementation!
    var mockNetworkingFacade: MockNetworkingFacade!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        mockNetworkingFacade = MockNetworkingFacade()
        systemUnderTest = MovieControllerImplementation(networkingController: mockNetworkingFacade)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockNetworkingFacade = nil
        systemUnderTest = nil
        try super.tearDownWithError()
    }

    func testLoadSingleMovieSuccess() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let expectation = self.expectation(description: "Expectation")
        
        mockNetworkingFacade.success =  true
        
        systemUnderTest.loadSingleMovie(movieId: "id") { result in
            switch result {
            case .success(let movie):
                XCTAssertNotNil(movie)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 0.2, handler: nil)
    }
    
    func testLoadSingleMovieFailure() {
        let expectation = self.expectation(description: "Expectation")
        
        mockNetworkingFacade.success = false
        
        systemUnderTest.loadSingleMovie(movieId: "id") { result in
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

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

class MockNetworkingFacade: NetworkingProtocol {
    var success = true
    
    func getSingleMovie(movieId: String, completion: @escaping SingleMovieResult) {
        if success {
            let mockMovie = MockMovie(id: 1, title: "titulo", originalTitle: "titutlo", posterPath: "url", releaseDate: "fecha", overview: "descripcion")
            completion(.success(mockMovie))
        } else {
            completion(.failure(MockError()))
        }
    }
    
    func getTopRated(page: Int, completion: @escaping MovieListResult) {
        
    }
    
    
}

struct MockMovie: MovieProtocol {
    var id: Int
    
    var title: String
    
    var originalTitle: String
    
    var posterPath: String
    
    var releaseDate: String
    
    var overview: String
}

struct MockError: Error {
    
}
