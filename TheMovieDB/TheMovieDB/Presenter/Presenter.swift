//
//  Presenter.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 20/10/2021.
//

import Foundation

class Presenter: PresenterProtocol
{
    
    
    var mainVC: ViewControllerProtocol
    
    var movieManager: MovieManagerProtocol = MovieManager(networkingController: NetworkingManager.shared)
    
    private var tableViewList: MovieListProtocol
    
    private var collectionViewList: MovieListProtocol
    
    init(viewController: ViewControllerProtocol, delegate : MovieListDelegateProtocol) {
        self.mainVC = viewController
        
        tableViewList = MovieTableView(movieListDelegate: delegate, movieListDataSource: MovieListDataSource(movieManager: movieManager))
        
        collectionViewList = MovieCollectionView(movieListDelegate: delegate, movieListDataSource: MovieListDataSource(movieManager: movieManager))
    }
    
    func getMovieList(type: MovieListType) -> MovieListProtocol {
        var movieList: MovieListProtocol
        
        switch type {
        case .grid:
            movieList = collectionViewList
        case .list:
            movieList = tableViewList
        }
        
        return movieList
    }
    
    func getViewModel(index: Int) -> DetailViewModelProtocol {
        let viewModel =  DetailViewModel(movie: (movieManager.topRatedMovies?[index])!)
        
        return viewModel
    }
    
    func loadSingleMovie(movieId: String, completion: @escaping SingleMovieResult) {
        self.movieManager.loadSingleMovie(movieId: movieId) { result in
            completion(result)
        }
    }
    
    func loadTopRated(completion: @escaping MovieListResult) {
        self.movieManager.loadTopRated() { result in
            completion(result)
        }
    }
}
