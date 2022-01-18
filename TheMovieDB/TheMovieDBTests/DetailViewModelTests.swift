//
//  DetailViewModel.swift
//  TheMovieDBTests
//
//  Created by Maximiliano Riquelme Vera on 12/10/2021.
//

import XCTest
@testable import TheMovieDB

class DetailViewModelTests: XCTestCase {
    
    func testDetailViewModelInit() {
        let mockMovie = MockMovie(id: 1, title: "Title", originalTitle: "Original Title", posterPath: "URL", releaseDate: "Date", overview: "Description")
        
        let sut = DetailViewModel(movie: mockMovie)
        
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut.englishTitle, mockMovie.title)
        XCTAssertEqual(sut.originalTitle, mockMovie.originalTitle)
        let expectURL = URL(string: "https://www.themoviedb.org/t/p/w1280\(mockMovie.posterPath)")
        XCTAssertNotNil(expectURL)
        XCTAssertEqual(sut.posterPath, expectURL)
        XCTAssertEqual(sut.releaseDate, "Release Date: \(mockMovie.releaseDate)")
        XCTAssertEqual(sut.overview, mockMovie.overview)
    }
}
