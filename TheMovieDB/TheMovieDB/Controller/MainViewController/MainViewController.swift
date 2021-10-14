//
//  TopRatedListVC.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 30/09/2021.
//

import UIKit

class MainViewController: UIViewController
{
    static let nibName = "MainViewController"
    
    let movieManager: MovieManagerProtocol = MovieManager(networkingController: NetworkingFacade.shared)
    
    lazy var movieList: MovieListProtocol = MovieCollectionView(movieListDelegate: self, movieListDataSource: MovieListDataSource(movieManager: movieManager))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Top Rated Movies"
        
        //Add the MovieList
        view.addSubview((movieList.view)!)
        applyConstraintsTo(superView: view, subView: (movieList.view)!)
        
        // Asks the MovieManager to load the top rated movies list
        movieManager.loadTopRated() { result in
            self.movieList.reloadData()
        }
    }
    
    private func applyConstraintsTo(superView: UIView, subView: UIView) {
        var constraints = [NSLayoutConstraint]()
        
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        constraints.append(subView.leadingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.leadingAnchor))
        constraints.append(subView.trailingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(subView.topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor))
        constraints.append(subView.bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
}

extension MainViewController: MovieListDelegateProtocol
{
    func loadDetailView(index: Int) {
        let detailView = DetailView(nibName: "DetailedView", bundle: nil)
        
        detailView.detailedManager =  DetailViewModel(movie: (self.movieManager.topRatedMovies?[index])!)
        
        self.navigationController?.pushViewController(detailView, animated: true)
    }
}
