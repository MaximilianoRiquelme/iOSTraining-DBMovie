//
//  MovieListCollectionView.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 29/09/2021.
//

import Foundation
import UIKit

class MovieCollectionView: UICollectionView, MovieListProtocol
{
    private let cellIdentifier: String = "MovieCollectionCell"
    
    var view: UIView?
    var movieListDataSource: MovieListDataSourceProtocol
    var movieListDelegate: MovieListDelegateProtocol
    
    required init(movieListDelegate: MovieListDelegateProtocol, movieListDataSource: MovieListDataSourceProtocol) {
        
        self.movieListDataSource = movieListDataSource
        self.movieListDelegate = movieListDelegate
        
        // Set up a layout for the MovieList as a Collection
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 200, height: 200)
        
        super.init(frame: .zero, collectionViewLayout: layout)
        
        // Register cell classes
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: cellIdentifier)
        self.dataSource = self
        self.delegate = self
        
        self.view = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func reloadData() {
        super.reloadData()
    }
}

// MARK: UICollectionViewDataSource
extension MovieCollectionView: UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return movieListDataSource.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieListDataSource.numberOfMoviesInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? MovieCollectionCell
        else {
            return MovieCollectionCell()
        }
        
        // Restores the cell properties before being reused
        cell.restoreCell()
        
        //Change the cell with the proper information
        var movie: MovieProtocol
        
        do {
            try movie = (movieListDataSource.cellForItemAt(indexPath: indexPath))
        } catch {
            return MovieCollectionCell()
        }
        
        cell.updateCell(movie: movie)
        
        return cell
    }
}

// MARK: UICollectionViewDelegateFLowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = self.view.frame.height
        let width = self.view.frame.width
        return CGSize(width: width/2.1, height: height/3)
    }
}

// MARK: UICollectionViewDelegate
extension MovieCollectionView: UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        movieListDelegate.loadDetailView(index: indexPath.row)
    }
}
