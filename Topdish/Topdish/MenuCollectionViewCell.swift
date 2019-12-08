//
//  MenuCollectionViewCell.swift
//  Topdish
//
//  Created by Gary Li on 11/24/19.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var DishImage: UIImageView!
    @IBOutlet weak var MenuLabel: UILabel!
    
    var menu:Menu?{
        didSet{
            self.updateUI()
        }
    }
    
    func updateUI(){
        if let menu = menu {
            DishImage.image = menu.dishImage
            MenuLabel?.text = menu.dishTitle
        }else{
            DishImage.image = nil
        }
        
        DishImage.layer.cornerRadius = 5.0;
        DishImage.layer.masksToBounds = true;
    }
}
