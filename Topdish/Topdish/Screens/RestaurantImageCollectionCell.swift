//
//  RestaurantImageCollectionCell.swift
//  Topdish
//
//  Created by Chris Chau on 2019-12-03.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import UIKit

class RestaurantImageCollectionCell: UICollectionViewCell {
    
    @IBOutlet var RestaurantImages: UIImageView!
    
    var restaurant: Restaurant! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
        if let restaurant = restaurant {
            RestaurantImages.image = restaurant.featuredImage
        } else {
            RestaurantImages.image = nil
        }
            
    }
}
