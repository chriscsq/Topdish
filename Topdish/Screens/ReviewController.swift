//
//  ReviewController.swift
//  Topdish
//
//  Created by Simran Bhattarai on 2019-12-03.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import Foundation
import UIKit
import Firebase
//import FirebaseAuth

class ReviewController:UIViewController, UITableViewDataSource, UITextViewDelegate, UITextFieldDelegate{
    //First page of the review
    //Store text field in theses
    var wygbplaceholder:String = "Would you go back?"
    var expplaceholder:String = "Tell us about your experience..."
    var dishNames:[String] = []
    var reviewHold:[DishReview] = []
    var rate:[Int] = []
    @IBOutlet weak var numDiner: UITextField!
    @IBOutlet weak var experience: UITextView!
    @IBOutlet weak var wouldyougoback: UITextView!
    @IBOutlet weak var addDish: UIButton!
    @IBOutlet weak var done: UIButton!
    @IBOutlet weak var table: UITableView!
    var counter:Int = 1
    var diners:Int = -1
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "reviewcell", for:indexPath)
       // if reviewHold[indexPath.row].rating != -1{
            
            cell.textLabel?.text = reviewHold[indexPath.row].name
            cell.detailTextLabel?.text = String(reviewHold[indexPath.row].rating)
            
        //}
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewHold.count
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = (self as? UITableViewDelegate)
        experience.delegate = self
        experience.textColor = .lightGray
        experience.text = expplaceholder
        
        wouldyougoback.delegate = self
        wouldyougoback.textColor = .lightGray
        wouldyougoback.text = wygbplaceholder
        
        numDiner.delegate = self
        
        
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         let dest = segue.destination as! DishReviewController
        //print(reviewHold)
        dest.reviewHolder = reviewHold
        dest.numdiners = diners
        dest.enteredExp = experience.text
        dest.enteredGoBack = wouldyougoback.text
    }
    
    func textViewDidBeginEditing(_ experience: UITextView) {
        if experience.textColor == UIColor.lightGray {
            experience.text = nil
            experience.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ experience: UITextView) {
        if experience.text.isEmpty {
            experience.text = "Tell us about your experience..."
            experience.textColor = UIColor.lightGray
        }else{
            //print(experience.text as! String)
        }
    }
    
    func textField(_ textField:UITextField, shouldChangeCharactersIn range: NSRange, replacementString string:String) -> Bool {
        return string == string.filter("0123456789".contains)
    }
    
    
    @IBAction func enterednumberofDiners(_ sender: UITextField) {
        guard let diners = Int(numDiner.text!) else {
                return
        }
    }
    
    
    @IBAction func submitReview(_ sender: UIButton){
        //Send everything to DB
        //func writeToDB(UID: String, restName: String, numberOfDiners: Int, experience: String, goBack: String, dishInfo: [(String, Double, String, String)])
        
        //writeToDB(UID: Auth.auth().currentUser?.uid, restName: String, numberOfDiners: diners, experience: expplaceholder, goBack: wygbplaceholder, dishInfo: [(String, Double, String, String)])
        //Thank you for sharing page
    }

    
    override func viewWillAppear(_ animated:Bool){
        
         super.viewWillAppear(animated)
    }

}
