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

    @IBOutlet weak var ReviewLabel: InsetLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        ReviewLabel.text = review
        ReviewLabel.backgroundColor = UIColor(hexString: "#FFEAD1")
        ReviewLabel.layer.cornerRadius = 5
        ReviewLabel.layer.masksToBounds = true

        // Configure the view for the selected state
    }
    
    

}

extension UIColor {
    convenience init?(hexString: String) {
        var chars = Array(hexString.hasPrefix("#") ? hexString.dropFirst() : hexString[...])
        let red, green, blue, alpha: CGFloat
        switch chars.count {
        case 3:
            chars = chars.flatMap { [$0, $0] }
            fallthrough
        case 6:
            chars = ["F","F"] + chars
            fallthrough
        case 8:
            alpha = CGFloat(strtoul(String(chars[0...1]), nil, 16)) / 255
            red   = CGFloat(strtoul(String(chars[2...3]), nil, 16)) / 255
            green = CGFloat(strtoul(String(chars[4...5]), nil, 16)) / 255
            blue  = CGFloat(strtoul(String(chars[6...7]), nil, 16)) / 255
        default:
            return nil
        }
        self.init(red: red, green: green, blue:  blue, alpha: alpha)
    }
}

 class InsetLabel: UILabel {
    var contentInsets = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)

     override func drawText(in rect: CGRect) {
        let insetRect = rect.inset(by: contentInsets)
        super.drawText(in: insetRect)
     }

     override var intrinsicContentSize: CGSize {
         return addInsets(to: super.intrinsicContentSize)
     }

     override func sizeThatFits(_ size: CGSize) -> CGSize {
         return addInsets(to: super.sizeThatFits(size))
     }

     private func addInsets(to size: CGSize) -> CGSize {
         let width = size.width + contentInsets.left + contentInsets.right
         let height = size.height + contentInsets.top + contentInsets.bottom
         return CGSize(width: width, height: height)
     }

 }
