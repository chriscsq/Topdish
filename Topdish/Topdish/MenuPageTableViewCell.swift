//
//  MenuPageTableViewCell.swift
//  Topdish
//
//  Created by Gary Li on 12/7/19.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import UIKit

class MenuPageTableViewCell: UITableViewCell {

    var name:String = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        print("sd")
        textLabel?.text = name
    }

}
