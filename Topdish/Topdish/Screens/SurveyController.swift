//
//  Profile.swift
//  Topdish
//
//  Created by Simran Bhattarai on 2019-11-30.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import UIKit
import ResearchKit

class SurveyController: UIViewController {
    
    @IBOutlet weak var Start: UIButton!
    
    override func viewDidLoad() {
        print("First I was afraid")
        super.viewDidLoad()
        
    }
    
    @IBAction func surveyTapped(sender : UIButton) {
           print("fuck")
           let taskViewController = ORKTaskViewController(task: SurveyTask, taskRun: nil)
           taskViewController.delegate = self as? ORKTaskViewControllerDelegate
           present(taskViewController, animated: true, completion: nil)
       }
    
}

