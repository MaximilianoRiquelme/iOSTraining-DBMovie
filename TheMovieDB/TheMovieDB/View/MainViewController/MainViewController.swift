//
//  TopRatedListVC.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 30/09/2021.
//

import UIKit

class MainViewController: UIViewController, ViewControllerProtocol
{
    static let nibName = "MainViewController"
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var movieList: MovieListProtocol?
    
    lazy var presenter: PresenterProtocol = Presenter(viewController: self, delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Top Rated Movies"
        
        //Create the movieList
        movieList = presenter.getMovieList(type: .list)
        
        //Add the MovieList
        if let view = movieList?.view {
            addMovieListView(movieListView: view)
        }
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        if let view = movieList?.view {
            view.removeFromSuperview()
        }
        
        let index = sender.selectedSegmentIndex
        
        if index == 0 {
            movieList = presenter.getMovieList(type: .list)
        }
        else if index == 1 {
            movieList = presenter.getMovieList(type: .grid)
        }
        
        if let view = movieList?.view {
            addMovieListView(movieListView: view)
        }
    }
    
    private func addMovieListView(movieListView: UIView)
    {
        view.addSubview(movieListView)
        applyConstraintsTo(superView: view, subView: movieListView)
        
        // Asks the MovieManager to load the top rated movies list
        DispatchQueue.global(qos: .userInteractive).async {
            self.presenter.loadTopRated { result in
                self.movieList?.reloadData()
            }
        }
    }
    
    private func applyConstraintsTo(superView: UIView, subView: UIView) {
        var constraints = [NSLayoutConstraint]()
        
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        constraints.append(subView.leadingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.leadingAnchor))
        constraints.append(subView.trailingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(subView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor))
        constraints.append(subView.bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
}

extension MainViewController: MovieListDelegateProtocol
{
    func loadDetailView(index: Int) {
        
        let detailView = DetailView(nibName: "DetailedView", bundle: nil)
        detailView.viewModel = presenter.getViewModel(index: index)
        
        if let navController = self.navigationController
        {
            navController.pushViewController(detailView, animated: true)
        }
    }
}
