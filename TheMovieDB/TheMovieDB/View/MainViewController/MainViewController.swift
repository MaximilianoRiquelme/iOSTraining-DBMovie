//
//  TopRatedListVC.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 30/09/2021.
//

import UIKit

class MainViewController: UIViewController, MainViewControllerProtocol
{
    
    
    static let nibName = "MainViewController"
    
    private lazy var presenter: PresenterProtocol = Presenter(mainVC: self)
    
    private var movieList: MovieListViewProtocol?
    
    @IBOutlet private  weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Top Rated Movies"
        
        //Create the movieList
        presenter.getMovieList(page: 1)
    }
    
    func updateMovieList(viewModel: MovieListViewModelProtocol) {
        
        if let view = movieList?.view {
            view.removeFromSuperview()
        }
        
        //TO-DO!!!
        
        //Add the MovieList
        if let view = movieList?.view {
            addMovieListView(movieListView: view)
        }
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        
        if index == 0 {
            presenter.getMovieList(page: 1)
        }
        else if index == 1 {
            presenter.getMovieList(page: 1)
        }
    }
    
    private func addMovieListView(movieListView: UIView)
    {
        view.addSubview(movieListView)
        applyConstraintsTo(superView: view, subView: movieListView)
        
        self.movieList?.reloadData()
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
        
        if let movie = movieList?.getMovieAt(index: index) {
            detailView.viewModel = DetailViewModel(movie: movie)
            
            if let navController = self.navigationController
            {
                navController.pushViewController(detailView, animated: true)
            }
        }
    }
}
