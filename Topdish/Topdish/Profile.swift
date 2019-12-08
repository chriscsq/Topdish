//
//  Profile.swift
//  Topdish
//
//  Created by Simran Bhattarai on 2019-12-07.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Profile {
    var name: String
    var profileImage: UIImage
    var coverImage: UIImage
    var review: [String: String]
    var bookmarked: [String]
    
    init(name:String, profileImage: UIImage, coverImage: UIImage, review: [String: String], bookmarked: [String]) {
        self.name = name
        self.profileImage = profileImage
        self.coverImage = coverImage
        self.review = review
        self.bookmarked = bookmarked
    }
    
    static func getBookmarked(profileID: String, completion: @escaping ([String]) -> Void) {
        var bookmarked : [String] = []
        
        let childString : String = "profile/" + profileID + "/bookmarked restaurants"
        
        Database.database().reference().child(childString).observeSingleEvent(of: .value) { snapshot in
            let bookmarkedRestaurants = snapshot.children
            while let singleRestaurant = bookmarkedRestaurants.nextObject() as? DataSnapshot {
                let restaurantName = singleRestaurant.key
                bookmarked.append(restaurantName)
                
            }
            completion(bookmarked)
        }
    }
    
    static func getReviewed(profileID: String, completion: @escaping ([String:String]) -> Void) {
        var reviewed : [String:String] = [:]
        
        let childString : String = "profile/" + profileID + "/user reviews"
        
        Database.database().reference().child(childString).observeSingleEvent(of: .value) { snapshot in
            let bookmarkedRestaurants = snapshot.children
            while let singleRestaurant = bookmarkedRestaurants.nextObject() as? DataSnapshot {
                let restaurantName = singleRestaurant.key
                let allReviews = singleRestaurant.children
                while let singleReview = allReviews.nextObject() as? DataSnapshot {
                    let dishName = singleReview.key
                    let textSnap = singleReview.childSnapshot(forPath: "text review").value
                    let textReview = (textSnap as! String)
                    let keyString = restaurantName + " - " + dishName
                    
                    reviewed[keyString] = textReview
                }
            }
            print(reviewed)
            completion(reviewed)
        }
    }
    
    static func getProfile(profileID: String, completion: @escaping (Profile) -> Void) {
        let childString : String = "profile/" + profileID
        Database.database().reference().child(childString).observeSingleEvent(of: .value) { snapshot in
            let user = snapshot.children
            
            while let userInfo = user.nextObject() as? DataSnapshot {
                if userInfo.key == "name" {
                    let nameSnap = userInfo.value
                    let name = (nameSnap as! String)
                    getReviewed(profileID: "Still need to decide on user identifier", completion: { reviews in
                        getBookmarked(profileID: "Still need to decide on user identifier", completion: { bookmark in
                            completion(Profile(name: name, profileImage: UIImage(named: "Burger")!, coverImage: UIImage(named: "Burger")!, review: reviews, bookmarked: bookmark) )
                        })
                    })

                } else {
                    continue
                }
            }
        }
    }
    

    
    
}
