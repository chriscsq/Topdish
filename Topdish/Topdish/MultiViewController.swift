//
//  MultiViewController.swift
//  Topdish
//
//  Created by Gary Li on 12/7/19.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import UIKit
import FirebaseDatabase

class MultiViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var appetizerTable: UITableView!
    @IBOutlet weak var drinksTable: UITableView!
    @IBOutlet weak var dessertTable: UITableView!
    @IBOutlet weak var mainTable: UITableView!
    var dishes: [String] = []
    var averageRating: [Double] = []
    var men = [Menu]()
    var m:Menu?
    
    var mainArray:[String] = []{
        didSet{
            mainTable.reloadData()
        }
    }
    var drinkArray:[String] = []{
        didSet{
            drinksTable.reloadData()
        }
    }
    var appetizerArray:[String] = []{
        didSet{
            appetizerTable.reloadData()
        }
    }
    var dessertArray:[String] = []{
        didSet{
            dessertTable.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
        getMainMenu()
        
        // Do any additional setup after loading the view.
        
        self.mainTable.dataSource = self
        self.mainTable.delegate = self
        
        self.appetizerTable.dataSource = self
        self.appetizerTable.delegate = self
        
        self.dessertTable.delegate = self
        self.dessertTable.dataSource = self
        
        self.drinksTable.delegate = self
        self.drinksTable.dataSource = self
        
    }
    
//
//    func getDish(_ resturant: String){
//        let childString : String = "menu/" + resturant
//        var counter: Double = 0
//        var totalRating: Double = 0
//        var rating = [Double]()
//        var userReview = [String]()
//        var i = 0
//        var description = "Database part"
//
//        Database.database().reference().child(childString).observe(.value, with: {snapshot in
//            if snapshot.exists() {
//                for a in ((snapshot.value as AnyObject).allKeys)!{
//                    self.dishes.append(a as! String)
//                }
//                self.dishes.reverse()
//
//                let singleRestaurant = snapshot.children
//
//                while let dishes = singleRestaurant.nextObject() as? DataSnapshot {
//                    let dishReviews = (dishes.childSnapshot(forPath: "user reviews")).children
//                    while let review = dishReviews.nextObject() as? DataSnapshot {
//                        let singleRating = review.childSnapshot(forPath: "rating").value
//
//                        totalRating += (singleRating as AnyObject).doubleValue
//                        counter += 1
//                        let singleTextReview = review.childSnapshot(forPath: "text review").value
//                        userReview.append(singleTextReview as! String)
//                        rating.append(singleRating as! Double)
//
//                    }
//
//                //    self.m = Menu(self.dishes[i], UIImage(named: "steak.png")!, rating, userReview, description)
//                    self.men.append(self.m!)
//                    self.averageRating.append(totalRating/counter)
//
//
//                    //reseting
//                    totalRating = 0
//                    counter = 0
//                    rating = [Double]()
//                    userReview = [String]()
//                    i = i + 1
//                }
//
//
//            }else{
//                print("DNE")
//            }
//        })
//    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "dishProfile"
        {
            let dest = segue.destination as! MultiViewController
        }
        }
    

    

}

extension MultiViewController: UITableViewDataSource{
    
    func getMainMenu() -> Void{
        print("sdad")
        //Menu.getReview(complete: { dishArray in self.dessertArray = dishArray})
        print(dessertArray)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if (tableView == self.mainTable){
//            return mainArray.count
//        }
        return mainArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView == self.mainTable){
            let cell = tableView.dequeueReusableCell(withIdentifier: "mainTableCell", for: indexPath) as! MenuPageTableViewCell
            print("sdadasdasda")
            cell.name = mainArray[indexPath.item]
            return cell
        }else if (tableView == self.appetizerTable){
            let cell = mainTable.dequeueReusableCell(withIdentifier: "apptizerTableCell", for: indexPath) as! MenuPageTableViewCell
            print("gfdgdfgdf")
            cell.name = mainArray[indexPath.item]
            return cell
        }else if (tableView == self.appetizerTable){
            let cell = mainTable.dequeueReusableCell(withIdentifier: "dessertTableCell", for: indexPath) as! MenuPageTableViewCell
            print("gfdgdfgdf")
            cell.name = mainArray[indexPath.item]
            return cell
        }else{
            let cell = mainTable.dequeueReusableCell(withIdentifier: "drinkTableCell", for: indexPath) as! MenuPageTableViewCell
            print("gfdgdfgdf")
            cell.name = mainArray[indexPath.item]
            return cell
        }
    }
    func getIndex(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) -> Int
    {
               print("selected \(indexPath.row)")
        return indexPath.row
    }
    
}
