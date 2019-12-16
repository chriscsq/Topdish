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
    var rating:Double
    var dishexp:String = ""
    
    init() {
        self.name = ""
        self.rating = -1.0
        self.dishexp = ""
    }
    
    init(name:String, rating: Double, dishexp:String) {
        self.name = name
        self.rating = rating
        self.dishexp = dishexp
    }
    
}

func writeToDB(UID: String, restName: String, numberOfDiners: Int, experience: String, goBack: String, dishInfo: [(String, Double, String, String)]) {

    let restPath = "restaurant/" + restName + "/reviews"
    let dishPath = "menu/" + restName + "/"
    let reviewPath = "review data/" + restName + "/" + UID

    Database.database().reference().child(restPath).setValue([UID: experience])
    Database.database().reference().child(reviewPath).setValue(["Number of Diners": numberOfDiners, "Would you go back": goBack])

    for dish in dishInfo {
        Database.database().reference().child(dishPath).observeSingleEvent(of: .value) { snapshot in
            if (snapshot.hasChild(dish.0)) {
                Database.database().reference().child(dishPath + dish.0 + "/user reviews/" + UID).setValue(["rating": dish.1, "text review": dish.2, "image": dish.3])

            } else {
                Database.database().reference().child(dishPath + dish.0).setValue(["section": "main"])
                Database.database().reference().child(dishPath + dish.0 + "/user reviews/" + UID).setValue(["rating": dish.1, "text review": dish.2, "image": dish.3])
            }
        }
    }
}
