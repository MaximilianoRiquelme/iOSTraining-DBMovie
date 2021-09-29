//
//  MyViewController.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 07/09/2021.
//

import UIKit

class TopRatedTableView: UIViewController {
    
    let movieController: MovieControllerProtocol = MovieControllerImplementation(networkingController: NetworkingFacade.shared)
    
    private let cellIdentifier = "MovieTableCell"
    
    @IBOutlet var moviesTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Top Rated Movies Table"
        
        // Register cell classes
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        moviesTableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        
        // Sets Delegate and DataSource
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        
        // Asks MovieController to load the top rated movies list
        movieController.loadTopRated() { result in
            self.moviesTableView.reloadData()
        }
    }
    
    func loadDetailedMovie(index: Int) {
        let detailView = DetailedView(nibName: "DetailedView", bundle: nil)
        
        detailView.detailedController =  DetailedControllerImplementation(movie: (self.movieController.topRatedMovies?[index])!)
        
        self.navigationController?.pushViewController(detailView, animated: true)
    }
}

/*
    Adds the required functions to manage the TableView
 */
extension TopRatedTableView: UITableViewDelegate, UITableViewDataSource
{
    //Called when a cell is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        loadDetailedMovie(index: indexPath.row)
    }
    
    //Sets the amount of rows on the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movieController.topRatedMovies?.count ?? Int.zero
    }
    
    //Loads all cells in order
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MovieTableCell
        else {
            return UITableViewCell()
        }
        
        // Restores the cell properties before being reused
        cell.restoreCell()
        
        //Change the cell with the proper information
        if let movie = movieController.topRatedMovies?[indexPath.row] {
            cell.updateCell(movie: movie)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
