//
//  UIImageView.swift
//  TheMovieDB
//
//  Created by Maximiliano Riquelme Vera on 07/09/2021.
//

import UIKit

extension UIImageView
{
    func loadFrom(url: URL) {
        DispatchQueue.global().async
        {
            [weak self] in
            
            if let data = try? Data(contentsOf: url)
            {
                if let image = UIImage(data: data)
                {
                    DispatchQueue.main.async
                    {
                        self?.image = image
                    }
                }
            }
        }
    }
}
