//
//  ReviewViewController.swift
//  Topdish
//
//  Created by Gary Li on 12/5/19.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {

    @IBOutlet weak var reviewLabel: UILabel!
    var review:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewLabel.text = review

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
