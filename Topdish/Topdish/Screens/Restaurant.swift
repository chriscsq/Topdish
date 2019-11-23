//
//  Restaurant.swift
//  Topdish
//
//  Created by Chris Chau on 2019-11-22.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import UIKit

class Restaurant {
    var name = ""
    var featuredImage: UIImage
 
    init(name: String, featuredImage: UIImage) {
        self.name = name
        self.featuredImage = featuredImage
    }
    
    static func fetchRestaurants() -> [Restaurant] {
        return [
            Restaurant(name: "Momofuku", featuredImage: UIImage(named: "Burger")!),
            Restaurant(name: "Vintage", featuredImage: UIImage(named: "steak")!),
            Restaurant(name: "Roku", featuredImage:UIImage(named: "Uni-Omakase")!),
                                  
        ]
    }
}
