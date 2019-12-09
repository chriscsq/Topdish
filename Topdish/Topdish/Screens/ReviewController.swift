//
//  ReviewController.swift
//  Topdish
//
//  Created by Simran Bhattarai on 2019-12-03.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import Foundation
import UIKit

class ReviewController:UIViewController, UITableViewDataSource, receiveData{
    //First page
    var dishNames:String = ""
    @IBOutlet weak var numDiner: UITextField!
    @IBOutlet weak var experience: UITextView!
    @IBOutlet weak var wouldyougoback: UITextView!
    @IBOutlet weak var addDish: UIButton!
    @IBOutlet weak var done: UIButton!
    @IBOutlet weak var table: UITableView!
    var counter:Int = 1
    var diners:Int?
    var rate:Int?
    //let vc = DishReviewController()
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "reviewcell", for:indexPath) as! DishCellController
        table.reloadData()
        
        cell.dishName?.text = ""
        cell.rating?.text = "4"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
            table.dataSource = self
            table.delegate = (self as? UITableViewDelegate)
        NotificationCenter.default.addObserver(self,
        selector: #selector(ReviewController.handleModalDismissed),
        name: NSNotification.Name(rawValue: "modalIsDimissed"),
        object: nil)
        //let vc2 = ReviewController()
        //vc2.delegate = self
        //vc2.sendDishname()
       
    }
    
    
    @IBAction func enterednumberofDiners(_ sender: UITextField) {
        //Number of Diners entered
        guard let diners = Int(numDiner.text!) else {
                return
        }
        //SAVE NUMBER OF DINERS HERE?
    }
    
    //Text views, no idea still how that works
    //experience
    //would you go back
    
    //Rest of the data, check the modal: Dish Review Controller


    @objc func handleModalDismissed() {
        //print("gets called now")
        table.reloadData()
        viewDidLoad()
     }
    
    override func viewWillAppear(_ animated:Bool){
        
         super.viewWillAppear(animated)
    }
    
    func sendDishname(dishname:String){
        print("whats happening")
        print(dishname)
        dishNames = dishname
    }
   
}
