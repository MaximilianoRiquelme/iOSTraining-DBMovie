//
//  MovieListFactory.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 01/10/2021.
//

import Foundation
import UIKit

class MovieListCreator
{
    func createMovieListAsTable(mainVC: MainViewController) -> MovieListProtocol {
        
        // Create the MovieList as a UIView
        let myMovieList = MovieTableView(frame: mainVC.view.frame, style: .plain)
        
        // Sets up Delegate and DataSouce
        myMovieList.delegate = mainVC
        myMovieList.movieListDataSource = MovieListDataSource()
        myMovieList.movieListDataSource?.movieManager = mainVC.movieManager
        
        //Add the MovieList
        mainVC.view.addSubview(myMovieList)
        applyConstraintsTo(superView: mainVC.view, subView: myMovieList)
        
        return myMovieList
    }
    
    func createMovieListAsGrid(mainVC: MainViewController) -> MovieListProtocol {
        
        // Set up a layout for the MovieList (Collection)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 200, height: 200)
        
        // Create the MovieList as a UIView
        let myMovieList = MovieCollectionView(frame: mainVC.view.frame, collectionViewLayout: layout)
        
        // Sets up Delegate and DataSouce
        myMovieList.delegate = mainVC
        myMovieList.movieListDataSource = MovieListDataSource()
        myMovieList.movieListDataSource?.movieManager = mainVC.movieManager
        
        //Add the MovieList
        mainVC.view.addSubview(myMovieList)
        applyConstraintsTo(superView: mainVC.view, subView: myMovieList)
        
        return myMovieList
    }
    
    private func applyConstraintsTo(superView: UIView, subView: UIView) {
        var constraints = [NSLayoutConstraint]()
        
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        constraints.append(subView.leadingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.leadingAnchor))
        constraints.append(subView.trailingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(subView.topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor))
        constraints.append(subView.bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
}
