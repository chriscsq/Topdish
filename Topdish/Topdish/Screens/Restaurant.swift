//
//  Restaurant.swift
//  Topdish
//
//  Created by Chris Chau on 2019-11-22.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import UIKit
import FirebaseDatabase

class Restaurant {
    var title = ""
    var featuredImage: UIImage
 
    init(title: String, featuredImage: UIImage) {
        self.title = title
        self.featuredImage = featuredImage
    }
    
    static func getRating(restaurant: String, completion: @escaping (Double) -> Void) {
        let childString : String = "menu/" + restaurant
        var counter: Double = 0
        var totalRating: Double = 0

        Database.database().reference().child(childString).observeSingleEvent(of: .value) { snapshot in
            let singleRestaurant = snapshot.children
            while let dishes = singleRestaurant.nextObject() as? DataSnapshot {
                let dishReviews = (dishes.childSnapshot(forPath: "user reviews")).children
                while let review = dishReviews.nextObject() as? DataSnapshot {
                    let singleRating = review.childSnapshot(forPath: "rating").value
                    totalRating += (singleRating as AnyObject).doubleValue
                    counter += 1
                }
            }
            completion(totalRating / counter)
        }
    }

    /* Queries the database and returns the top highest rated restaurants */
    static func getTopPlaces() -> [Restaurant] {
        return [
            Restaurant(title: "Momofuku", featuredImage: UIImage(named: "Burger")!),
            Restaurant(title: "Vintage", featuredImage: UIImage(named: "steak")!),
            Restaurant(title: "Roku", featuredImage:UIImage(named: "Uni-Omakase")!),
                                  
        ]
    }
    
    /* Queries the database and returns a list of restaurants within a certain km, sorted by nearest */
    static func getNearby() -> [Restaurant] {
        return [
            Restaurant(title: "Vintage", featuredImage: UIImage(named: "steak")!),
            Restaurant(title: "Momofuku", featuredImage: UIImage(named: "Burger")!),
            Restaurant(title: "Roku", featuredImage:UIImage(named: "Uni-Omakase")!),
                                  
        ]
    }
    
    /* Queries the database and returns a list of restaurants with ongoing offers
     * Based on offer start and end date */
    static func getExclusiveOffers() -> [Restaurant] {
        return [
            Restaurant(title: "Roku", featuredImage:UIImage(named: "Uni-Omakase")!),
            Restaurant(title: "Momofuku", featuredImage: UIImage(named: "Burger")!),
            Restaurant(title: "Vintage", featuredImage: UIImage(named: "steak")!),
                                  
        ]
    }
}
