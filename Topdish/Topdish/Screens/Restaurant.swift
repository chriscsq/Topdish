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
    var title: String
    var featuredImage: UIImage
    var typeOfCuisine: String
    var rating: Double
    
    init(title: String, featuredImage: UIImage, typeOfCuisine: String, rating: Double ) {
        self.title = title
        self.featuredImage = featuredImage
        self.typeOfCuisine = typeOfCuisine
        self.rating = rating
    }
    
    /* Queries the database to return the ratings for a single restaurant
     * goes through all the dishes and returns a double which is the average user rating */
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
    
    /* Queries the database and returns a list of all restaurants */
    static func getRestaurantList(complete: @escaping ([Restaurant]) -> Void) {
        var restaurants: [Restaurant] = []
        
        Database.database().reference().child("restaurant").observeSingleEvent(of: .value) { snapshot in
            let allRestaurants = snapshot.children
            while let singleRestaurant = allRestaurants.nextObject() as? DataSnapshot {
                let restName: String = singleRestaurant.key
                //let featuredImage = singleRestaurant.childSnapshot(forPath: "image").value
                let category = singleRestaurant.childSnapshot(forPath: "category").value
                let restType = (category as! String)
                getRating(restaurant: restName, completion: { myVal in
                    restaurants.append(Restaurant(title: restName, featuredImage: UIImage(named: "steak")!, typeOfCuisine: restType, rating: myVal))
                    complete(restaurants)
                    // If this doesn't work we can try appending where we are calling it and doing ...
                    //complete([Restaurant(title: restName, featuredImage: UIImage(named: featuredImage)!, typeOfCuisine: restType, rating: myVal)])
                })
            }
        }
    }
    
    /* Queries the database and returns a list of restaurants within a certain km, sorted by nearest */
    static func getNearby(complete: @escaping ([Restaurant]) -> Void) {
        var topPlaces: [Restaurant] = []
        
        Database.database().reference().child("restaurant").observeSingleEvent(of: .value) { snapshot in
            let allRestaurants = snapshot.children
            while let singleRestaurant = allRestaurants.nextObject() as? DataSnapshot {
                let restName: String = singleRestaurant.key
                //let featuredImage = singleRestaurant.childSnapshot(forPath: "image").value
                let category = singleRestaurant.childSnapshot(forPath: "category").value
                let restType = (category as! String)
                getRating(restaurant: restName, completion: { myVal in
                    topPlaces.append(Restaurant(title: restName, featuredImage: UIImage(named: "steak")!, typeOfCuisine: restType, rating: myVal))
                    complete(topPlaces)
                    // If this doesn't work we can try appending where we are calling it and doing ...
                    //complete([Restaurant(title: restName, featuredImage: UIImage(named: featuredImage)!, typeOfCuisine: restType, rating: myVal)])
                })
            }
        }
    }
    
    
    /* Queries the database and returns a list of restaurants with ongoing offers
     * Based on offer start and end date */
    static func getExclusiveOffers(complete: @escaping ([Restaurant]) -> Void) {
        var topPlaces: [Restaurant] = []
        
        Database.database().reference().child("restaurant").observeSingleEvent(of: .value) { snapshot in
            let allRestaurants = snapshot.children
            while let singleRestaurant = allRestaurants.nextObject() as? DataSnapshot {
                let restName: String = singleRestaurant.key
                //let featuredImage = singleRestaurant.childSnapshot(forPath: "image").value
                let category = singleRestaurant.childSnapshot(forPath: "category").value
                let restType = (category as! String)
                getRating(restaurant: restName, completion: { myVal in
                    topPlaces.append(Restaurant(title: restName, featuredImage: UIImage(named: "steak")!, typeOfCuisine: restType, rating: myVal))
                    complete(topPlaces)
                    // If this doesn't work we can try appending where we are calling it and doing ...
                    //complete([Restaurant(title: restName, featuredImage: UIImage(named: featuredImage)!, typeOfCuisine: restType, rating: myVal)])
                })
            }
        }
    }
    
}
