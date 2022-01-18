//
//  PresenterProtocol.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 20/10/2021.
//

import Foundation

enum PresenterError: Error
{
    case urlError
    case parsingError
}

protocol PresenterProtocol
{
    var mainVC: MainViewControllerProtocol { get }
    
    func getMovieList(page: Int)
}
