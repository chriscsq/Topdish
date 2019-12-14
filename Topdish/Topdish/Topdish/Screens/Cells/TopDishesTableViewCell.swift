//
//  TopDishesTableViewCell.swift
//  Topdish
//
//  Created by Chris Chau on 2019-12-07.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import UIKit

class TopDishesTableViewCell: UITableViewCell {

    var dishName: String = ""
    @IBOutlet weak var DishLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        DishLabel.text = dishName
        // Configure the view for the selected state
    }

}
