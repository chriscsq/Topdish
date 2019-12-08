//
//  ReviewTableViewCell.swift
//  Topdish
//
//  Created by Chris Chau on 2019-12-08.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    var review: String = ""
    @IBOutlet weak var ReviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        ReviewLabel.text = review
        // Configure the view for the selected state
    }

}
