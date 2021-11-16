//
//  PresenterTest.swift
//  TheMovieDBTests
//
//  Created by Maximiliano Riquelme Vera on 21/10/2021.
//

import XCTest
@testable import TheMovieDB

let mockMovie = TopRatedMovie(adult: true, backdropPath: "URL", genreIDS:[1], id: 1, originalLanguage: "Language", originalTitle: "Title", overview: "Description", popularity: Double.zero, posterPath: "URL", releaseDate: "Date", title: "Title", video: true, voteAverage: Double.zero, voteCount: 1)

class PresenterTest: XCTestCase {
    
    private var sut: Presenter!
    private var mockMainViewController: MainViewControllerProtocol!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockMainViewController = MockMainViewController()
        sut = Presenter(mainVC: mockMainViewController)
        sut.movieManager = MockMovieManager()
    }

    override func tearDownWithError() throws {
        mockMainViewController = nil
        sut = nil
        try super.tearDownWithError()
    }

    func testGetMovieList() throws {
        sut.getMovieList(page: 1)
    }
}

class MockMainViewController: MainViewControllerProtocol
{
    func updateMovieList(viewModel: MovieListViewModelProtocol) {
        
        let obtainedMovie = viewModel.movies?.first
        
        XCTAssertEqual(obtainedMovie?.title, mockMovie.title)
        XCTAssertEqual(obtainedMovie?.originalTitle, mockMovie.originalTitle)
        XCTAssertEqual(obtainedMovie?.posterPath, mockMovie.posterPath)
        XCTAssertEqual(obtainedMovie?.releaseDate, mockMovie.releaseDate)
        XCTAssertEqual(obtainedMovie?.overview, mockMovie.overview)
    }
}

class MockMovieManager: MovieManagerProtocol
{
    func loadTopRated(page: Int, completion: @escaping MovieManagerResult) {
        let topRatedList = TopRatedList(page: 1, results: [mockMovie], totalPages: 1, totalResults: 1)
        completion(.success(topRatedList))
    }
}

struct MockMovie: MovieProtocol
{
    var id: Int
    
    var title: String
    
    var originalTitle: String
    
    var posterPath: String
    
    var releaseDate: String
    
    var overview: String
}
