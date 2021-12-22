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
    var movieManager: APIClientProtocol = APIClient(baseURL: "api.themoviedb.org")
    
    init(mainVC: MainViewControllerProtocol) {
        self.mainVC = mainVC
    }
    
    func getMovieList(page: Int) {
        self.movieManager.loadTopRated(page: page) { [weak self] (result) in
            DispatchQueue.main.async {
                guard let self = self else {
                    return
                }
                
                switch result {
                    case .success(let topRatedList):
                        let viewModel = MovieListViewModel(movies: topRatedList.results)
                        self.mainVC.updateMovieList(viewModel: viewModel)
                    case .failure(_):
                        self.mainVC.showErrorMessage(message: "The operation couldn't be completed.")
                        let viewModel = MovieListViewModel(movies: [MovieProtocol]())
                        self.mainVC.updateMovieList(viewModel: viewModel)
                        
                }
            }
        }
    }
}
