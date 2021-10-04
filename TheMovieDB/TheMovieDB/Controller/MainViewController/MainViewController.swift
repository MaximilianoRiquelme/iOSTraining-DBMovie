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
    
    let movieManager: MovieManagerProtocol = MovieManager(networkingController: NetworkingManager.shared)
    
    var movieList: MovieListProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Top Rated Movies"
        
        // Creates the MovieList
        //let myMovieList = MovieCollectionView(frame: view.frame, movieManager: movieManager)
        let myMovieList = MovieTableView(frame: view.frame, movieManager: movieManager)
        myMovieList.delegate = self
        movieList = myMovieList
        
        //Add the MovieList
        view.addSubview((movieList?.view)!)
        applyConstraintsTo(superView: view, subView: (movieList?.view)!)
        
        // Asks the MovieManager to load the top rated movies list
        movieManager.loadTopRated() { result in
            self.movieList?.reloadData()
        }
    }
    
    func loadDetailedMovie(index: Int) {
        let detailView = DetailedView(nibName: "DetailedView", bundle: nil)
        
        detailView.detailedController =  DetailedManager(movie: (self.movieManager.topRatedMovies?[index])!)
        
        self.navigationController?.pushViewController(detailView, animated: true)
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

// MARK: UICollectionViewDelegates
extension MainViewController: UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        loadDetailedMovie(index: indexPath.row)
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 300)
    }
}

// MARK: UITableViewDelegate
extension MainViewController: UITableViewDelegate
{
    //Called when a cell is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        loadDetailedMovie(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
