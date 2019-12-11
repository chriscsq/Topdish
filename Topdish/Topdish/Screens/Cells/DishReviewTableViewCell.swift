//
//  DishReviewTableViewCell.swift
//  Topdish
//
//  Created by Gary Li on 12/4/19.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import UIKit
import QuartzCore

class DishReviewTableViewCell: UITableViewCell {

  
    @IBOutlet weak var reviewLabel: UILabel!
    var dish = DishProfileViewController()
    var review: String!
    var rate: (Double,String) = (0.0,"")
    var test = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
   
        
      //  ratingLabel?.text = " \(String(format:"%.2f", rate))"
       // detailTextLabel?.text = review
        reviewLabel?.text = "Rating \(String(format:"%.2f", rate.0))\n\n" + rate.1
        
        reviewLabel.layer.masksToBounds = true
        reviewLabel.layer.cornerRadius = 5

    }



    
    


}

