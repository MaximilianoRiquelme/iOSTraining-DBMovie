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
    var movieManager: MovieManagerProtocol = MovieManager(networkingController: NetworkingManager())
    
    init(mainVC: MainViewControllerProtocol) {
        self.mainVC = mainVC
    }
    
    func getMovieList(page: Int) {
        self.movieManager.loadTopRated(page: page) { (result) in
            DispatchQueue.main.async {
                switch result
                {
                    case .success(let topRatedList):
                        let viewModel = MovieListViewModel(movies: topRatedList.results)
                        self.mainVC.updateMovieList(viewModel: viewModel)
                    case .failure(_):
                        let viewModel = MovieListViewModel(movies: [MovieProtocol]())
                        self.mainVC.updateMovieList(viewModel: viewModel)
                }
            }
        }
    }
}
