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
    
    var movieListDataSource: MovieListDataSource?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        // Register cell classes
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        self.register(nib, forCellReuseIdentifier: cellIdentifier)
        self.dataSource = self
        
        self.rowHeight = 150
        self.contentMode = .scaleToFill
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func reloadData() {
        super.reloadData()
    }
}

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
