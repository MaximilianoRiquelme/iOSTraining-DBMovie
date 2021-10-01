//
//  MovieDetailView.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 06/09/2021.
//

import UIKit

class DetailedView: UIViewController
{
    @IBOutlet var englishTitle: UILabel!
    @IBOutlet var originalTitle: UILabel!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var releaseDate: UILabel!
    @IBOutlet var overview: UILabel!
    
    var detailedController: DetailedManagerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadDetails()
    }

    func loadDetails() {
        DispatchQueue.main.async {
            self.title = self.detailedController?.englishTitle
            
            self.originalTitle.text = self.detailedController?.originalTitle
            
            if let url = self.detailedController?.posterPath {
                self.posterImageView.load(url: url)
            }
            
            self.releaseDate.text = self.detailedController?.releaseDate
            self.overview.text = self.detailedController?.overview
        }
    }
}
