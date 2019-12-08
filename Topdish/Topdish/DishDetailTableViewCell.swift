//
//  DishDetailTableViewCell.swift
//  Topdish
//
//  Created by Gary Li on 11/28/19.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import UIKit

class DishDetailTableViewCell: UITableViewCell {

    var menu:Menu?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        print("\(menu)")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
