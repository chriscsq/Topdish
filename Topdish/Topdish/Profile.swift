//
//  Profile.swift
//  Topdish
//
//  Created by Simran Bhattarai on 2019-12-07.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Profile{
    var name:String
    var profileImage:UIImage
    var coverImage:UIImage
    var review: [String: [String]]
    var bookmarked:[String: [String]]
    
    init(name:String, profileImage:UIImage, coverImage:UIImage, review:[String: [String]], bookmarked:[String: [String]]) {
        self.name = name
        self.profileImage = profileImage
        self.coverImage = coverImage
        self.review = review
        self.bookmarked = bookmarked
    }
}
