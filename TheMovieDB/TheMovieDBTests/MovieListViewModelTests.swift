//
//  MovieListViewModelTests.swift
//  TheMovieDBTests
//
//  Created by Maximiliano Riquelme Vera on 18/11/2021.
//

import XCTest
@testable import TheMovieDB

class MovieListViewModelTests: XCTestCase {

    func testDetailViewModelInit() {
        let mockMovie = MockMovie(id: 1, title: "Title", originalTitle: "Original Title", posterPath: "URL", releaseDate: "Date", overview: "Description")
        
        let sut = MovieListViewModel(movies: [mockMovie])
        XCTAssertNotNil(sut)
        
        let movie = sut.movies?.first
        XCTAssertEqual(movie?.title, mockMovie.title)
        XCTAssertEqual(movie?.originalTitle, mockMovie.originalTitle)
        XCTAssertEqual(movie?.posterPath, mockMovie.posterPath)
        XCTAssertEqual(movie?.releaseDate, mockMovie.releaseDate)
        XCTAssertEqual(movie?.overview, mockMovie.overview)
    }
}
