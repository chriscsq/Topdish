//
//  DishCellController.swift
//  Topdish
//
//  Created by Simran Bhattarai on 2019-12-07.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class DishReview {
    var name:String = ""
    var rating:Int
    
    init() {
        self.name = ""
        self.rating = -1
    }
    
    init(name:String, rating: Int) {
        self.name = name
        self.rating = rating
    }
    
}

func writeToDB(UID: String, restName: String, numberOfDiners: Int, experience: String, goBack: String, dishInfo: [(String, Double, String, String)]) {
    
    let restPath = "restaurant/" + restName + "/reviews"
    let dishPath = "menu/" + restName
    let reviewPath = "review data/" + restName + "/" + UID
    
    Database.database().reference().child(restPath).setValue([UID: experience])
    Database.database().reference().child(reviewPath).setValue(["Number of Diners": numberOfDiners])
    Database.database().reference().child(reviewPath).setValue(["Would you go back": goBack])
    
    for dish in dishInfo {
        Database.database().reference().child(dishPath).observeSingleEvent(of: .value) { snapshot in
            if (snapshot.hasChild(dish.0)) {
                let newSnap = snapshot.childSnapshot(forPath: dish.0)
                if (newSnap.hasChild(UID)) {
                    ///Database.database().reference().child(dishPath + dish.0 + "user reviews" + UID).setValue(["image": ADD IMAGE STRING FOR KARN use dish.3 to access UIImage type])
                    Database.database().reference().child(dishPath + dish.0 + "user reviews" + UID).setValue(["rating": dish.1])
                    Database.database().reference().child(dishPath + dish.0 + "user reviews" + UID).setValue(["text review": dish.2
                    ])
                } else {
                    Database.database().reference().child(dishPath + dish.0 + "user reviews").setValue([UID: ["rating": dish.1]])
                    Database.database().reference().child(dishPath + dish.0 + "user reviews").setValue([UID: ["text review": dish.2]])
                    ///Database.database().reference().child(dishPath + dish.0 + "user reviews").setValue([UID: ["image": dish.3 FOR KARN @@@@@@@@@@@@]])
                }
            } else {
                print("This dish does not exist in our DB!")
            }
        }
    }
    
}
