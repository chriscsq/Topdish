//
//  DishCellController.swift
//  Topdish
//
//  Created by Simran Bhattarai on 2019-12-07.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import Foundation
import UIKit

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
