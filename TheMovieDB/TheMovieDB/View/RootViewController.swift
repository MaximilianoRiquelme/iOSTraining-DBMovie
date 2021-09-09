//
//  MyViewController.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 07/09/2021.
//

import UIKit

class RootViewController: UIViewController {
    
    @IBOutlet var moviesTableView: UITableView!
    
    let moviesController = MovieControllerImp()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadTableView()
    }
    
    func loadDetailedMovie(index: Int) {
        let detailView = DetailedView(nibName: "DetailedView", bundle: nil)
        
        detailView.detailedController =  DetailedControllerImp(movie: (self.moviesController.topRatedMovies?[index])!)
        
        let navVC = UINavigationController(rootViewController: detailView)
        navVC.modalPresentationStyle = .popover
        
        self.present(navVC, animated: true)
    }
}

/*
    Adds the required functions to manage the TableView
 */
extension RootViewController: UITableViewDelegate, UITableViewDataSource
{
    func loadTableView() {
        let nib = UINib(nibName: "MovieCell", bundle: nil)
        moviesTableView.register(nib, forCellReuseIdentifier: "MovieCell")
        
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        
        //moviesTableView.rowHeight = UITableView.automaticDimension
        moviesTableView.estimatedRowHeight = UITableView.automaticDimension
        
        moviesController.loadTopRated() { result in
            self.moviesTableView.reloadData()
        }
    }
        
    //Called when a cell is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        loadDetailedMovie(index: indexPath.row)
    }
    
    //Sets the amount of rows on the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return moviesController.topRatedMovies?.count ?? Int.zero
    }
    
    //Loads all cells in order
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell
        else {
            return UITableViewCell()
        }
        
        //Change the cell with the proper information
        if let movie = moviesController.topRatedMovies?[indexPath.row] {
            cell.updateCell(movie: movie)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
