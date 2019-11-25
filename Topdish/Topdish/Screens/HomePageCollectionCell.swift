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
    @IBOutlet weak var restaurantRatingLabel: UILabel?
    @IBOutlet weak var restaurantCuisineLabel: UILabel?
    
    var restaurant: Restaurant! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
        if let restaurant = restaurant {
            featuredImageView.image = restaurant.featuredImage
            restaurantNameLabel?.text = restaurant.title
            restaurantRatingLabel?.text = String(restaurant.rating)
            restaurantCuisineLabel?.text = restaurant.typeOfCuisine
             
        } else {
            featuredImageView.image = nil
            restaurantNameLabel = nil
            restaurantRatingLabel = nil
            restaurantCuisineLabel = nil
        }
        
        /* Image display settings for collection cells */
        featuredImageView.layer.cornerRadius = 5.0;
        featuredImageView.layer.masksToBounds = true;
        
    }
    
}
