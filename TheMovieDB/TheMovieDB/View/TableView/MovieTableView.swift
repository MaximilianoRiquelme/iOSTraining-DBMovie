//
//  MovieTableView.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 01/10/2021.
//

import Foundation
import UIKit

class MovieTableView: UITableView, MovieListViewProtocol
{
    private let cellIdentifier: String = "MovieTableCell"
    
    var view: UIView?
    var movieListDataSource: MovieListDataSourceProtocol
    var movieListDelegate: MovieListDelegateProtocol
    
    required init(movieListDelegate: MovieListDelegateProtocol, viewModel: MovieListViewModelProtocol) {
        self.movieListDataSource = MovieListDataSource(viewModel: viewModel)
        self.movieListDelegate = movieListDelegate
        
        super.init(frame: .zero, style: .plain)
        
        // Register cell classes
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        self.register(nib, forCellReuseIdentifier: cellIdentifier)
        self.dataSource = self
        self.delegate = self
        
        self.rowHeight = 150
        self.contentMode = .scaleToFill
        
        self.view = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func reloadData() {
        super.reloadData()
    }
    
    func getMovieAt(index: Int) -> MovieProtocol? {
        do {
            return try movieListDataSource.movieForItemAt(index: index)
        } catch {
            return nil
        }
    }
}

// MARK: UITableViewDataSource
extension MovieTableView: UITableViewDataSource
{
    //Sets the amount of rows on the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movieListDataSource.numberOfMoviesInSection(section: section)
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
            try movieData = (movieListDataSource.movieForItemAt(index: indexPath.row))
        } catch {
            return MovieTableCell()
        }
        
        cell.updateCell(movie: movieData)
        
        return cell
    }
}

// MARK: UITableViewDelegate
extension MovieTableView: UITableViewDelegate
{
    //Called when a cell is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        movieListDelegate.loadDetailView(index: indexPath.row)
    }
}
