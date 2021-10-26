//
//  PresenterTest.swift
//  TheMovieDBTests
//
//  Created by Maximiliano Riquelme Vera on 21/10/2021.
//

import XCTest
@testable import TheMovieDB

let mockMovie = MockMovie(id: 1, title: "Title", originalTitle: "Original Title", posterPath: "URL", releaseDate: "Date", overview: "Description")

class PresenterTest: XCTestCase {
    
    private var sut: Presenter!
    private var mockViewController: ViewControllerProtocol!
    private var mockMovieListDelegate: MovieListDelegateProtocol!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockViewController = MockViewController()
        mockMovieListDelegate = MockMovieListDelegate()
        sut = Presenter(viewController: mockViewController, delegate: mockMovieListDelegate)
        sut.movieManager = MockMovieManager()
    }

    override func tearDownWithError() throws {
        mockViewController = nil
        mockMovieListDelegate = nil
        sut = nil
        try super.tearDownWithError()
    }

    func testGetMovieList() throws {
        var movieList: MovieListProtocol
        
        movieList = sut.getMovieList(type: .grid)
        XCTAssertTrue(movieList is MovieCollectionView)
        
        movieList = sut.getMovieList(type: .list)
        XCTAssertTrue(movieList is MovieTableView)
    }
    
    func testLoadDetailView() throws {
        let viewModel = sut.getViewModel(index: 0)
        
        XCTAssertNotNil(sut)
        XCTAssertEqual(viewModel.englishTitle, mockMovie.title)
        XCTAssertEqual(viewModel.originalTitle, mockMovie.originalTitle)
        let expectURL = URL(string: "https://www.themoviedb.org/t/p/w1280\(mockMovie.posterPath)")
        XCTAssertNotNil(expectURL)
        XCTAssertEqual(viewModel.posterPath, expectURL)
        XCTAssertEqual(viewModel.releaseDate, "Release Date: \(mockMovie.releaseDate)")
        XCTAssertEqual(viewModel.overview, mockMovie.overview)
    }
}

class MockViewController: ViewControllerProtocol
{
    
}

class MockMovieListDelegate: MovieListDelegateProtocol
{
    func loadDetailView(index: Int) {
        
    }
}

class MockMovieManager: MovieManagerProtocol
{
    var networkingManager: NetworkingManagerProtocol = MockNetworkingManager()
    
    var singleMovie: MovieProtocol? = mockMovie
    
    var topRatedMovies: [MovieProtocol]? = [mockMovie]
    
    func loadTopRated(page: Int, completion: @escaping MovieListResult) {
        if let result = topRatedMovies {
            completion(.success(result))
        }
    }
    
    
}
