//
//  InsetLabel.swift
//  Topdish
//
//  Created by Chris Chau on 2019-12-14.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import UIKit

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
