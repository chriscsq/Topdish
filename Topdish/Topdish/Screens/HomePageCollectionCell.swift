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
    @IBOutlet weak var restaurantNameLabel: UILabel?
    
    var restaurant: Restaurant! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
        if let restaurant = restaurant {
            featuredImageView.image = restaurant.featuredImage
            restaurantNameLabel?.text = restaurant.title
             
        } else {
            featuredImageView.image = nil
           // restaurantNameLabel = nil
        }
        
        /* Image display settings for collection cells */
        featuredImageView.layer.cornerRadius = 5.0;
        featuredImageView.layer.masksToBounds = true;
        
    }
    
}
