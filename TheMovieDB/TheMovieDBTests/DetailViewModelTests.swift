//
//  DetailViewModel.swift
//  TheMovieDBTests
//
//  Created by Maximiliano Riquelme Vera on 12/10/2021.
//

import XCTest
@testable import TheMovieDB

class DetailViewModelTests: XCTestCase {
    
    private let mockMovie = MockMovie(id: 1, title: "Title", originalTitle: "Original Title", posterPath: "URL", releaseDate: "Date", overview: "Description")
    
    var systemUnderTest: DetailViewModelProtocol!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        systemUnderTest = DetailViewModel(movie: mockMovie)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        systemUnderTest = nil
        try super.tearDownWithError()
    }
    
    func testDetailViewModelInit() {
        XCTAssertNotNil(systemUnderTest)
        XCTAssertEqual(systemUnderTest.englishTitle, mockMovie.title)
        XCTAssertEqual(systemUnderTest.originalTitle, mockMovie.originalTitle)
        XCTAssertEqual(systemUnderTest.posterPath, URL(string: "https://www.themoviedb.org/t/p/w1280\(mockMovie.posterPath)"))
        XCTAssertEqual(systemUnderTest.releaseDate, "Release Date: \(mockMovie.releaseDate)")
        XCTAssertEqual(systemUnderTest.overview, mockMovie.overview)
    }
}
