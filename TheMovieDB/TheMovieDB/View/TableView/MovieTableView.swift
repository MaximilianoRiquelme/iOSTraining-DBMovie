//
//  MovieTableView.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 01/10/2021.
//

import Foundation
import UIKit

class MovieTableView: UITableView, MovieListProtocol
{
    private let cellIdentifier: String = "MovieTableCell"
    
    var view: UIView?
    var movieListDataSource: MovieListDataSource?
    
    init(frame: CGRect, movieManager: MovieManagerProtocol) {
        super.init(frame: frame, style: .plain)
        
        // Register cell classes
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        self.register(nib, forCellReuseIdentifier: cellIdentifier)
        self.dataSource = self
        //self.delegate = self
        
        self.rowHeight = 150
        self.contentMode = .scaleToFill
        
        self.movieListDataSource = MovieListDataSource()
        self.movieListDataSource?.movieManager = movieManager
        
        view = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func reloadData() {
        super.reloadData()
    }
}

// MARK: UITableViewDataSource
extension MovieTableView: UITableViewDataSource
{
    //Sets the amount of rows on the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movieListDataSource?.numberOfItemsInSection(section: section) ?? Int.zero
    }
    
    //Loads all cells in order
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MovieTableCell
        else {
            return MovieTableCell()
        }
        
        // Restores the cell properties before being reused
        cell.restoreCell()
        
        //Change the cell with the proper information
        var movieData: MovieProtocol
        
        do {
            try movieData = (movieListDataSource?.cellForItemAt(indexPath: indexPath))!
        } catch {
            return MovieTableCell()
        }
        
        cell.updateCell(movie: movieData)
        
        return cell
    }
}
/*
// MARK: UITableViewDelegate
extension MovieTableView: UITableViewDelegate
{
    //Called when a cell is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        loadDetailedMovie(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
*/
