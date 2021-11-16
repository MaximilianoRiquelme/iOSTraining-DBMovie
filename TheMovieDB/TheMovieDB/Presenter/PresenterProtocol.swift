//
//  PresenterProtocol.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 20/10/2021.
//

import Foundation

protocol PresenterProtocol
{
    var mainVC: MainViewControllerProtocol { get }
    
    func getMovieList(page: Int)
}
