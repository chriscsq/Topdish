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
    var rate: Double!
    var test = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
   
        
      //  ratingLabel?.text = " \(String(format:"%.2f", rate))"
       // detailTextLabel?.text = review
        reviewLabel?.text = "Rating \(String(format:"%.2f", rate))\n\n" + test
        
        reviewLabel.layer.masksToBounds = true
        reviewLabel.layer.cornerRadius = 5
        
        
//        detailTextLabel?.adjustsFontSizeToFitWidth = false
//        detailTextLabel?.lineBreakMode = .byTruncatingTail
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("row")
    }
    


    
    


}

