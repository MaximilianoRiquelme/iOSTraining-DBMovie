//
//  TheMovieDBTests.swift
//  TheMovieDBTests
//
//  Created by Jaime Laino on 8/2/21.
//

import XCTest
@testable import TheMovieDB

class MovieManagerTests: XCTestCase {
    
    private var systemUnderTest: MovieManager!
    private var mockNetworkingManager: MockNetworkingFacade!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        mockNetworkingManager = MockNetworkingFacade()
        systemUnderTest = MovieManager(networkingController: mockNetworkingManager)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockNetworkingManager = nil
        systemUnderTest = nil
        try super.tearDownWithError()
    }

    func testLoadSingleMovieSuccess() throws {
        let expectation = self.expectation(description: "Expectation")
        
        mockNetworkingManager.success =  true
        
        systemUnderTest.loadSingleMovie(movieId: "id") { result in
            switch result {
            case .success(let movie):
                XCTAssertNotNil(movie)
                XCTAssertEqual(movie.id, self.mockNetworkingManager.mockMovie.id)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 0.2, handler: nil)
    }
    
    func testLoadSingleMovieFailure() {
        let expectation = self.expectation(description: "Expectation")
        
        mockNetworkingManager.success = false
        
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
    
    func testLoadTopRatedSuccess() {
        let expectation = self.expectation(description: "Expectation")
        
        mockNetworkingManager.success =  true
        
        systemUnderTest.loadTopRated() { result in
            switch result {
            case .success(let myMovies):
                XCTAssertNotNil(myMovies)
                XCTAssertEqual(myMovies[0].id, self.mockNetworkingManager.mockMovie.id)
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
        
        systemUnderTest.loadTopRated() { result in
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

class MockNetworkingFacade: NetworkingManagerProtocol {
    
    var success = true
    
    let mockMovie = MockMovie(id: 1, title: "Title", originalTitle: "Original Title", posterPath: "URL", releaseDate: "Date", overview: "Description")
    
    func getSingleMovie(movieId: String, completion: @escaping SingleMovieResult) {
        if success {
            completion(.success(mockMovie))
        } else {
            completion(.failure(MockError()))
        }
    }
    
    func getTopRated(page: Int, completion: @escaping MovieListResult) {
        if success {
            let movieArray = Array.init(arrayLiteral: mockMovie)
            completion(.success(movieArray))
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
