//
//  MovieDetailView.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 06/09/2021.
//

import UIKit

class DetailView: UIViewController
{
    @IBOutlet var englishTitle: UILabel!
    @IBOutlet var originalTitle: UILabel!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var releaseDate: UILabel!
    @IBOutlet var overview: UILabel!
    
    var viewModel: DetailViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadModel()
    }

    func loadModel() {
        DispatchQueue.main.async {
            self.title = self.viewModel?.englishTitle
            
            self.originalTitle.text = self.viewModel?.originalTitle
            
            if let url = self.viewModel?.posterPath {
                self.posterImageView.loadFrom(url: url)
            }
            
            self.releaseDate.text = self.viewModel?.releaseDate
            self.overview.text = self.viewModel?.overview
        }
    }
}
