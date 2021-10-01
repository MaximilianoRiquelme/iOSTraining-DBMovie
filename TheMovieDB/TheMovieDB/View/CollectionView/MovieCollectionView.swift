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
    
    var movieListDataSource: MovieListDataSource?
    
    override init(frame: CGRect, collectionViewLayout: UICollectionViewLayout)
    {
        super.init(frame: frame, collectionViewLayout: collectionViewLayout)
        
        // Register cell classes
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: cellIdentifier)
        self.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func reloadData() {
        super.reloadData()
    }
}

extension MovieCollectionView: UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return movieListDataSource?.numberOfSections() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieListDataSource?.numberOfItemsInSection(section: section) ?? 0
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
            try movie = (movieListDataSource?.cellForItemAt(indexPath: indexPath))!
        } catch {
            return MovieCollectionCell()
        }
        
        cell.updateCell(movie: movie)
        
        return cell
    }
}
