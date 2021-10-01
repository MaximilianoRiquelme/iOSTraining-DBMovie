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
    
    let movieListCreator = MovieListCreator()
    
    var movieList: MovieListProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Top Rated Movies"
        
        movieList = movieListCreator.createMovieListAsGrid(mainVC: self)
        
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
