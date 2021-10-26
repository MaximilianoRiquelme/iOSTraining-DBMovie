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
        
        let dataSource = MovieListDataSource(movieManager: movieManager)
        
        tableViewList = MovieTableView(movieListDelegate: delegate, movieListDataSource: dataSource)
        collectionViewList = MovieCollectionView(movieListDelegate: delegate, movieListDataSource: dataSource)
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
    
    func loadTopRated(page: Int, completion: @escaping MovieListResult) {
        self.movieManager.loadTopRated(page: page) { result in
            completion(result)
        }
    }
}
