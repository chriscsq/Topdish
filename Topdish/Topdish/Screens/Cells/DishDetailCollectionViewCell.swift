//
//  DishDetailCollectionViewCell.swift
//  Topdish
//
//  Created by Gary Li on 11/28/19.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import UIKit

class DishDetailCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!

    @IBOutlet weak var imagesView: UIImageView!
    
    var dish = DishProfileViewController()
    var rate: Double!
    var menu: UIImage! {
            didSet {
                self.updateUI()
            }
        }

     var profile = DishProfileViewController()
        func updateUI() {
            print("celllo", menu!)
            
            if let menu = menu {
                imagesView.image = menu
            }
          
            imagesView.layer.cornerRadius = 5.0;
            imagesView.layer.masksToBounds = true;
            
        }
    
 
    
    
    
    
}
