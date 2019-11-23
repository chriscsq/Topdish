//
//  homepage.collectionview.cell.swift
//  Topdish
//
//  Created by Chris Chau on 2019-11-22.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//
import UIKit

class HomePageCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var restaurantImageView: UIImageView!
    
    var restaurant: Restaurant! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
        
        if let restaurant = restaurant {
            restaurantImageView.image = restaurant.featuredImage
            //restaurantImageView.text = restaurant.title
            //restaurantImageRating. ?? = ??
             
        } else {
            restaurantImageView.image = nil
        }
        
        restaurantImageView.layer.cornerRadius = 5.0;
        restaurantImageView.layer.masksToBounds = true;
        
    }
    
}
