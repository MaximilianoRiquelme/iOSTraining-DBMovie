//
//  TheMovieDBTests.swift
//  TheMovieDBTests
//
//  Created by Jaime Laino on 8/2/21.
//

import XCTest
import OHHTTPStubs

@testable import TheMovieDB

class APIClientTests: XCTestCase {
    
    private var sut: APIClient!

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    
    func testLoadTopRatedSuccess() {
        //Setup network Stubs.
        let testHost = "test.org"
        let page = 1
        
        stub(condition: isHost("test.org")) { _ in
            guard let path = OHPathForFile("topRatedList.json", type(of: self))
            else {
                    preconditionFailure("Could not find expected file in test bundle")
            }

            return HTTPStubsResponse(
                fileAtPath: path,
                statusCode: 200,
                headers: [ "Content-Type": "application/json" ]
            )
        }
        
        //Setup the System under test
        sut = APIClient(baseURL: testHost)
        
        //Start of the test.
        let expectation = self.expectation(description: "Expectation")
        
        sut.loadTopRated(page: page) { result in
            switch result {
            case .success(let topRatedList):
                XCTAssertEqual(topRatedList.page, 1)
                XCTAssertEqual(topRatedList.totalResults, 1)
                XCTAssertEqual(topRatedList.totalPages, 1)
                XCTAssertEqual(topRatedList.results.first?.adult, true)
                XCTAssertEqual(topRatedList.results.first?.backdropPath, "/backdroppath.jpg")
                XCTAssertEqual(topRatedList.results.first?.genreIDS, [1,2,3])
                XCTAssertEqual(topRatedList.results.first?.id, 1)
                XCTAssertEqual(topRatedList.results.first?.originalLanguage, "language")
                XCTAssertEqual(topRatedList.results.first?.originalTitle, "originaltitle")
                XCTAssertEqual(topRatedList.results.first?.overview, "overview")
                XCTAssertEqual(topRatedList.results.first?.popularity, 1)
                XCTAssertEqual(topRatedList.results.first?.posterPath, "/posterpath.jpg")
                XCTAssertEqual(topRatedList.results.first?.releaseDate, "2001")
                XCTAssertEqual(topRatedList.results.first?.title, "title")
                XCTAssertEqual(topRatedList.results.first?.video, false)
                XCTAssertEqual(topRatedList.results.first?.voteAverage, 10)
                XCTAssertEqual(topRatedList.results.first?.voteCount, 1)
            case .failure(_):
                XCTFail()
            }
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 60, handler: nil)
    }
    
    func testLoadTopRatedSuccessEmptyList() {
        //Setup network Stubs.
        let testHost = "test.org"
        let page = 1
        
        stub(condition: isHost("test.org")) { _ in
            guard let path = OHPathForFile("topRatedListEmpty.json", type(of: self))
            else {
                    preconditionFailure("Could not find expected file in test bundle")
            }

            return HTTPStubsResponse(
                fileAtPath: path,
                statusCode: 200,
                headers: [ "Content-Type": "application/json" ]
            )
        }
        
        //Setup the System under test
        sut = APIClient(baseURL: testHost)
        
        //Start of the test.
        let expectation = self.expectation(description: "Expectation")
        
        sut.loadTopRated(page: page) { result in
            switch result {
            case .success(let topRatedList):
                XCTAssertEqual(topRatedList.page, 1)
                XCTAssertEqual(topRatedList.totalResults, 0)
                XCTAssertEqual(topRatedList.totalPages, 1)
                XCTAssertEqual(topRatedList.results.description, "[]")
            case .failure(_):
                XCTFail()
            }
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 60, handler: nil)
    }
     
    func testLoadTopRatedFailure() {
        //Setup network Stubs.
        let testHost = "test.org"
        let page = 1
        
        stub(condition: isHost("test.org")) { _ in
            let error = NSError(domain: "test", code: 42, userInfo: [:])
            return HTTPStubsResponse(error: error)
        }
        
        //Setup the System under test
        sut = APIClient(baseURL: testHost)

        //Start of the test.
        let expectation = self.expectation(description: "Expectation")
        
        sut.loadTopRated(page: page ) { result in
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
