//
//  Menu.swift
//  Topdish
//
//  Created by Gary Li on 11/24/19.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import UIKit
import FirebaseDatabase

class Menu {
    
    var restaurantName: String
    var dishes: [Dish] = []
//    private var _dishes: [Dish]!
//    var dishes: [Dish] {
//        didSet{
//            self.dishes = populate(restaurantName)
//        }
//
//        set{self.dishes = populate(restaurantName)}
//        get{return _dishes}
//    }
//       var dishTitle = ""
//       var dishImage: UIImage
//    var rating = [Double]()
//    var userReview = [String]()
//    var dishes = [Dish]
//    var description = ""
    
//    init(_ dishTitle: String,_ dishImage: UIImage) {
//           self.dishTitle = dishTitle
//           self.dishImage = dishImage
//    }
    init(restaurantName: String){
        self.restaurantName = restaurantName
        
        populateDish(restaurantName, completion: { allDishes in
            self.dishes = allDishes
        })
        
        //self.dishes = populate(restaurantName)
    }
    
    init() {
        self.restaurantName = ""
        self.dishes = [Dish.init()]
    }
    
    
    func populateDish(_ restaurantName: String, completion: @escaping ([Dish]) -> Void) {
        var myDishes: [Dish] = []
        let childString : String = "menu/" + restaurantName
        Database.database().reference().child(childString).observeSingleEvent(of: .value) { snapshot in
            let singleRestaurant = snapshot.children
            while let dishes = singleRestaurant.nextObject() as? DataSnapshot {
                let dishName = dishes.key
                myDishes.append(Dish.init(restaurantName: restaurantName, dishName: dishName))
            }
            completion(myDishes)
        }
    }
    
    func populate(_ restaurantName: String) -> [Dish] {
        populateDish(restaurantName, completion: { allDishes in
            self.dishes = allDishes
        })
        return []
    }

/*
    init(_ dishTitle: String,_ dishImage: UIImage,_ rating: [Double],_ userReview: [String], _ description: String) {
           self.dishTitle = dishTitle
           self.dishImage = dishImage
        self.rating = rating
        self.userReview = userReview
        self.description = description
       } */
    
    
    /*
    func getMenu (restaurant: String) -> [Menu]
        go through your db
        append
    */
    
    
}
