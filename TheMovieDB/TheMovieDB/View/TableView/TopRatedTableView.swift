//
//  MyViewController.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 07/09/2021.
//

import UIKit

class TopRatedTableView: UIViewController {
    
    private let cellIdentifier = "MovieTableCell"
    
    @IBOutlet var moviesTableView: UITableView!
    
    let moviesController = MovieControllerImplementation(networkingController: NetworkingFacade.shared)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadTableView()
    }
    
    func loadDetailedMovie(index: Int) {
        let detailView = DetailedView(nibName: "DetailedView", bundle: nil)
        
        detailView.detailedController =  DetailedControllerImplementation(movie: (self.moviesController.topRatedMovies?[index])!)
        
        self.navigationController?.pushViewController(detailView, animated: true)
    }
}

/*
    Adds the required functions to manage the TableView
 */
extension TopRatedTableView: UITableViewDelegate, UITableViewDataSource
{
    func loadTableView() {
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        moviesTableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        self.title = "Top Rated Movies"
        
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
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MovieTableCell
        else {
            return UITableViewCell()
        }
        
        cell.restoreCell()
        
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
