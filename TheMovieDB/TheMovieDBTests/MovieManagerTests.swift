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
        mockNetworkingManager.mockMovie = MockMovie(id: 1, title: "Title", originalTitle: "Original Title", posterPath: "URL", releaseDate: "Date", overview: "Description")
        
        sut.loadTopRated(page: 1) { result in
            switch result {
            case .success(let myMovies):
                XCTAssertNotNil(myMovies)
                XCTAssertEqual(myMovies[0].id, self.mockNetworkingManager.mockMovie?.id)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 0.2, handler: nil)
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
    var mockMovie: MovieProtocol?
    
    func getTopRated(page: Int, completion: @escaping MovieListResult) {
        if success {
            if let movie = mockMovie {
                let movieArray = Array.init(arrayLiteral: movie)
                completion(.success(movieArray))
            }
            
        } else {
            completion(.failure(MockError()))
        }
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
