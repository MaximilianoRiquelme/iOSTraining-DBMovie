//
//  RootVIewController.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 28/09/2021.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let firstViewController = TopRatedCollectionView(nibName: "TopRatedCollectionView", bundle : nil)
        
    }
}
