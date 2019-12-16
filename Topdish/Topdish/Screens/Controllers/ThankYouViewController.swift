//
//  ThankYouViewController.swift
//  Topdish
//
//  Created by Chris Chau on 2019-12-15.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import UIKit

class ThankYouViewController: UIViewController {

    @IBOutlet weak var Done: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func DoneButtonPressed(_ sender: Any) {
        let vc = HomePageController() 
        self.present(vc, animated: true, completion: nil)
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
