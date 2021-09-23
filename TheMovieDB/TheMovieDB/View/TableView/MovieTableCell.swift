//
//  MovieCell.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 08/09/2021.
//

import UIKit

class MovieTableCell: UITableViewCell {

    @IBOutlet var englishTitle: UILabel!
    @IBOutlet var posterImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func restoreCell()
    {
        self.englishTitle.text = "Loading..."
        self.posterImage.image = nil
    }
    
    func updateCell(movie: MovieProtocol)
    {
        //Updates title
        self.englishTitle.text = movie.title
        
        //Finally, loads the image from url
        if let url = URL(string: "https://www.themoviedb.org/t/p/w1280\(movie.posterPath)") {
            self.posterImage.load(url: url)
        }
    }
}
