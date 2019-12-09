//
//  Restaurant.swift
//  Topdish
//
//  Created by Chris Chau on 2019-11-22.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import UIKit
import FirebaseDatabase
import CoreLocation
import MapKit
import Darwin

class Restaurant {
    var title: String
    var featuredImage: UIImage?
    var typeOfCuisine: String
    var rating: Double
    var distance: Double
    var address: String
    var rank: Int
    var reviews: [String] = ["this is some bad ass poo", "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum"]
    
    var menu: [String] = ["Steak", "Burger", "Chili cheese", "Bubble tea"]


    /* Hours */
    // MARK: SETUP
    init(title: String, featuredImage: UIImage, typeOfCuisine: String, rating: Double, distance: Double, address: String, rank: Int) {
        self.title = title
        self.featuredImage = featuredImage
        self.typeOfCuisine = typeOfCuisine
        self.rating = rating
        self.distance = distance
        self.address = address
        self.rank = rank
        //self.menu = func -> Menu
    }
    
    init() {
        self.title = ""
        self.featuredImage = nil
        self.typeOfCuisine = ""
        self.rating = 0
        self.distance = Double.greatestFiniteMagnitude
        self.address = ""
        self.rank = 99
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
    
    static func ignoreme() -> String {
        let number = Int.random(in: 0 ..< 4)
        if (number == 1) {
            return "Burger"
        } else if (number == 2) {
            return "steak"
        } else if (number == 3) {
            return "flatbread"
        } else {
            return "Uni-Omakase"
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
                let addressOfRest = singleRestaurant.childSnapshot(forPath: "address").value
                let restAddress = (addressOfRest as! String)
                getRating(restaurant: restName, completion: { myVal in
                    restaurants.append(Restaurant(title: restName, featuredImage: UIImage(named: ignoreme())!, typeOfCuisine: restType, rating: myVal, distance: 0, address: restAddress, rank: 0))
                    complete(restaurants)
                })
            }
        }
    }
    
    /* Used to build a near me list, outputs a list of reastaurants which are closest to you by distance.
        Requires location permission */
    static func sortByAddress(myLocation: CLLocationCoordinate2D, restaurantArray: [Restaurant], complete: @escaping ([Restaurant]) -> Void) {
        for restaurant in restaurantArray {
            let address = restaurant.address
            
            let geoCoder = CLGeocoder()
            geoCoder.geocodeAddressString(address) { (placemarks, error) in
                guard
                    let placemarks = placemarks,
                    let location = placemarks.first?.location
                else {
                    // handle no location found -- Can set default ? Will try later.
                    print("Cannot find location based on address String.")
                    restaurant.distance = 99999999999
                    return
                }
                let sourceP = CLLocation.init(latitude: myLocation.latitude, longitude: myLocation.longitude)
                
                restaurant.distance = location.distance(from: sourceP)
                complete(restaurantArray.sorted { $0.distance > $1.distance })

            }
        }
    }
    
    /* Queries the database and returns a list of restaurants within a certain km, sorted by nearest */
    static func getNearby(location: CLLocationCoordinate2D, complete: @escaping ([Restaurant]) -> Void) {
            getRestaurantList(complete: { restaurantArray in
                sortByAddress(myLocation: location, restaurantArray: restaurantArray, complete: { newRestaurantArray in
                    complete(newRestaurantArray)
                })
            })
    }
    
    
    /* Queries the database and returns a list of restaurants with ongoing offers
     * Based on offer start and end date */
    static func getExclusiveOffers(complete: @escaping ([Restaurant]) -> Void) {
        var offeredPlaces: [Restaurant] = []
        Database.database().reference().child("offers").observeSingleEvent(of: .value) { snapshot in
            let allOffers = snapshot.children
            while let singleOffer = allOffers.nextObject() as? DataSnapshot {
                let restName: String = singleOffer.key
                let rankShot = singleOffer.childSnapshot(forPath: "rank").value
                let myRank = (rankShot as! Int)
                Database.database().reference().child("restaurant").observeSingleEvent(of: .value) { restSnapshot in
                    let allResaurants = restSnapshot.children
                    while let singleRestaurant = allResaurants.nextObject() as? DataSnapshot {
                        if singleRestaurant.key == restName {
                            //let featuredImage = singleRestaurant.childSnapshot(forPath: "image").value
                            let category = singleRestaurant.childSnapshot(forPath: "category").value
                            let restType = (category as! String)
                            let addressOfRest = singleRestaurant.childSnapshot(forPath: "address").value
                            let restAddress = (addressOfRest as! String)
                            getRating(restaurant: restName, completion: { myVal in
                                offeredPlaces.append(Restaurant(title: restName, featuredImage: UIImage(named: "steak")!, typeOfCuisine: restType, rating: myVal, distance: 0, address: restAddress, rank: myRank))
                                complete(offeredPlaces)
                            })
                        } else {
                            continue
                        }
                    }
                }
            }
        }
    }
}
