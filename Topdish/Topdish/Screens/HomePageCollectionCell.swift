//
//  homepage.collectionview.cell.swift
//  Topdish
//
//  Created by Chris Chau on 2019-11-22.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//
import UIKit

class HomePageCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var featuredImageView: UIImageView!
    
    var restaurant: Restaurant! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
        
        if let restaurant = restaurant {
            featuredImageView.image = restaurant.featuredImage
            //restaurantImageView.text = restaurant.title
            //restaurantImageRating. ?? = ??
             
        } else {
            featuredImageView.image = nil
        }
        
        featuredImageView.layer.cornerRadius = 5.0;
        featuredImageView.layer.masksToBounds = true;
        
    }
    
}
