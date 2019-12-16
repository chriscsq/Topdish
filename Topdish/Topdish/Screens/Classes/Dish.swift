//
//  Dish.swift
//  Topdish
//
//  Created by Gary Li on 12/7/19.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class Dish{
    var restaurantName: String
    var dishName: String
    var section: String = ""
    var review: [(Double,String)] = []
    var image: [String] = []
    //var backupImage: UIImage
    
    
    init(restaurantName: String, dishName : String){
        self.restaurantName = restaurantName
        self.dishName = dishName
        
        
        // Should test if this works in time ... if Dish.review = [] ... Did not work in time.
        populateReview(restaurantName, completion: { allReviews in
            self.review = allReviews
        })
        populateImage(restaurantName, completion: { allImages in
            self.image = allImages
//            print("ASDASDAS : ", self.dishName, self.section)
        })
        
        //self.backupImage = UIImage(named: "Burger")!

    }
    
    init() {
        self.restaurantName = ""
        self.dishName = ""
        self.review = []
        self.image = []
        self.section = ""
    }
    
    func populateReview(_ restaurantName: String, completion: @escaping ([(Double,String)]) -> Void) {
        var myReviews: [(Double,String)] = []
        let childString : String = "menu/" + restaurantName
        Database.database().reference().child(childString).observeSingleEvent(of: .value) { snapshot in
            let singleRestaurant = snapshot.children
            while let dishes = singleRestaurant.nextObject() as? DataSnapshot {
                if dishes.key == self.dishName {
                    if dishes.hasChild("user reviews") {
                        let dishReviews = (dishes.childSnapshot(forPath: "user reviews")).children
                        while let review = dishReviews.nextObject() as? DataSnapshot {
                            let singleRatingSnap = review.childSnapshot(forPath: "rating").value
                            let singleReviewSnap = review.childSnapshot(forPath: "text review").value
                            let singleRating = (singleRatingSnap as AnyObject).doubleValue!
                            let singleReview = (singleReviewSnap as! String)
                            myReviews.append((singleRating,singleReview))
                        }
                    }
                }
            }
            completion(myReviews)
        }
    }
    
    func populateImage(_ restaurantName: String, completion: @escaping ([String]) -> Void) {
        let storageRef = Storage.storage().reference().child("restaurant").child(restaurantName)
        var myImages: [String] = []
//        var uiImages: [UIImage] = []
        let childString : String = "menu/" + restaurantName
        Database.database().reference().child(childString).observeSingleEvent(of: .value) { snapshot in
            let singleRestaurant = snapshot.children
            while let dishes = singleRestaurant.nextObject() as? DataSnapshot {
                if dishes.key == self.dishName {
                    let sectionSnap = dishes.childSnapshot(forPath: "section").value
                    let section = (sectionSnap as! String)
                    self.section = section
                    let dishReviews = (dishes.childSnapshot(forPath: "user reviews")).children
                    while let review = dishReviews.nextObject() as? DataSnapshot {
                        if review.hasChild("image") {
                            
                            // MARK: for images from storage
                            // MARK: need more info on displaying format
//                            storageRef.child(self.dishName).listAll{ (result, error) in
//                                if let error = error {
//                                    print(error.localizedDescription)
//                                }
//                                for item in result.items {
//                                    print(item.fullPath)
//                                    item.downloadURL(completion:{ (url, error) in
//                                        print(url?.absoluteString as Any)
//                                        let data = NSData(contentsOf: url!)
//                                        let image = UIImage(data: data! as Data)
//                                        uiImages.append(image!)
//                                        myImages.append(url!.absoluteString)
//                                    })
//                                }
//                            }
                            let singleImageSnap = review.childSnapshot(forPath: "image").value
                            let singleImage = (singleImageSnap as! String)
                            myImages.append(singleImage)
                        }
                    }
                }
            }
            completion(myImages)
        }
    }
}
