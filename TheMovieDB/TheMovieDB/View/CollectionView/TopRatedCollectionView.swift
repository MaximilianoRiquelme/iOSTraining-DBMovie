//
//  ViewController.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 24/09/2021.
//

import UIKit

class TopRatedCollectionView: UIViewController
{
    let movieController: MovieControllerProtocol = MovieControllerImplementation(networkingController: NetworkingFacade.shared)
    
    private let cellIdentifier = "MovieCollectionCell"
    
    @IBOutlet var moviesCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Top Rated Movies Collection"
        
        // Register cell classes
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        moviesCollectionView!.register(nib, forCellWithReuseIdentifier: cellIdentifier)
        
        // Sets Delegate and DataSource
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        
        // Sets Layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 200, height: 200)
        moviesCollectionView.collectionViewLayout = layout
        
        // Asks MovieController to load the top rated movies list
        movieController.loadTopRated() { result in
            self.moviesCollectionView.reloadData()
        }
    }
    
    func loadDetailedMovie(index: Int) {
        let detailView = DetailedView(nibName: "DetailedView", bundle: nil)
        
        detailView.detailedController =  DetailedControllerImplementation(movie: (self.movieController.topRatedMovies?[index])!)
        
        self.navigationController?.pushViewController(detailView, animated: true)
    }
}

// MARK: UICollectionViewDataSource
extension TopRatedCollectionView: UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movieController.topRatedMovies?.count ?? Int.zero
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? MovieCollectionCell
        else {
            return MovieCollectionCell()
        }
        
        // Restores the cell properties before being reused
        cell.restoreCell()
        
        //Change the cell with the proper information
        if let movie = movieController.topRatedMovies?[indexPath.row] {
            cell.updateCell(movie: movie)
        }
        return cell
    }
}


// MARK: UICollectionViewDelegate
extension TopRatedCollectionView: UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        loadDetailedMovie(index: indexPath.row)
    }
}

extension TopRatedCollectionView: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
}
