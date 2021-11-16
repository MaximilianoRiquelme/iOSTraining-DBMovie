//
//  Presenter.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 20/10/2021.
//

import Foundation
import UIKit

class Presenter: PresenterProtocol
{
    var mainVC: MainViewControllerProtocol
    var movieManager: MovieManagerProtocol = MovieManager(networkingController: NetworkingManager.shared)
    
    init(mainVC: MainViewControllerProtocol) {
        self.mainVC = mainVC
    }
    
    func getMovieList(page: Int) {
        let viewModel = MovieListViewModel()
        
        self.movieManager.loadTopRated(page: page) {
            (result) in
                DispatchQueue.main.async {
                    switch result
                    {
                        case .success(let topRatedList):
                            viewModel.movies = topRatedList.results
                        case .failure(_):
                            viewModel.movies = [MovieProtocol]()
                    }
                }
        }
        
        mainVC.updateMovieList(viewModel: viewModel)
    }
    
    /*
    func getDetailViewModel(index: Int) -> DetailViewModelProtocol {
        let viewModel =  DetailViewModel(movie: (movieManager.topRatedMovies?[index])!)
        
        return viewModel
    }
     */
}
