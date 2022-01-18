//
//  MovieCollectionCell.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 24/09/2021.
//

import UIKit

class MovieCollectionCell: UICollectionViewCell
{
    @IBOutlet var posterImage: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
}

extension MovieCollectionCell: MovieListCellProtocol
{
    func restoreCell() {
        self.posterImage.image = nil
    }
    
    func updateCell(movie: MovieProtocol) {
        // Loads the image from url
        if let url = URL(string: "https://www.themoviedb.org/t/p/w1280\(movie.posterPath)") {
            self.posterImage.loadFrom(url: url) {
                self.activityIndicator.stopAnimating()
            }
        }
    }
}
