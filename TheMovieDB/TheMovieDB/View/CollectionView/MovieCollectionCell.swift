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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

extension MovieCollectionCell: MovieListCell
{
    func restoreCell() {
        self.posterImage.image = nil
    }
    
    func updateCell(movie: MovieProtocol) {
        // Loads the image from url
        if let url = URL(string: "https://www.themoviedb.org/t/p/w1280\(movie.posterPath)") {
            self.posterImage.load(url: url)
        }
    }
}
