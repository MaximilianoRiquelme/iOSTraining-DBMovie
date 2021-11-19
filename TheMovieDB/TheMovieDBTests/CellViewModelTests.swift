//
//  CellViewModelTests.swift
//  TheMovieDBTests
//
//  Created by Maximiliano Riquelme Vera on 18/11/2021.
//

import XCTest
@testable import TheMovieDB

class CellViewModelTests: XCTestCase {

    func testDetailViewModelInit() {
        let mockMovie = MockMovie(id: 1, title: "Title", originalTitle: "Original Title", posterPath: "URL", releaseDate: "Date", overview: "Description")
        
        let sut = CellViewModel(movie: mockMovie)
        
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut.englishTitle, mockMovie.title)
        let expectURL = URL(string: "https://www.themoviedb.org/t/p/w1280\(mockMovie.posterPath)")
        XCTAssertNotNil(expectURL)
        XCTAssertEqual(sut.posterPath, expectURL)
    }
}
