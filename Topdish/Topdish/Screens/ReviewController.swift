//
//  ReviewController.swift
//  Topdish
//
//  Created by Simran Bhattarai on 2019-12-03.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import Foundation
import ResearchKit

class ReviewController:UIViewController{
    
    @IBOutlet weak var Work: UIButton!
    
    @IBAction func surveyTapped(sender : AnyObject) {
        let taskViewController = ORKTaskViewController(task: SurveyTask, taskRun: nil)
        taskViewController.delegate = (self as! ORKTaskViewControllerDelegate)
        present(taskViewController, animated: true, completion: nil)
    }
}
