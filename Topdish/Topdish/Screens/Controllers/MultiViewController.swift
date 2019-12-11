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
    var dishFinder:String = ""
    var dishes: [String] = []
    var averageRating: [Double] = []
    var menu:Menu!
    var m:Menu?
    
    var mainArray:[(String,String,Double)] = []{
            didSet{
                mainTable.reloadData()
            }
        }
        var drinkArray:[(String,String,Double)] = []{
            didSet{
                drinksTable.reloadData()
            }
        }
        var appetizerArray:[(String,String,Double)] = []{
            didSet{
                appetizerTable.reloadData()
            }
        }
        var dessertArray:[(String,String,Double)] = []{
            didSet{
                dessertTable.reloadData()
            }
        }
        override func viewDidLoad() {
            super.viewDidLoad()

            for i in menu.dishes{
                print("menu \(i)")
            }
            getSection()
            
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
        
        
        // MARK: - Navigation

        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
            if segue.identifier == "dishProfile" {
               
                for i in menu.dishes {
                    if (i.dishName == dishFinder){
                         let dest = segue.destination as! DishProfileViewController
                        print("seaguing \(i.review)")
                        dest.menu = i.review
                        print("I want to leave")
                        break;
                    }
                }
            }
        }
        

        

    }

    extension MultiViewController: UITableViewDataSource{
        
        func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }
        
        func getSection() -> Void {
            for dish in self.menu.dishes {
                print(dish.section)
                switch dish.section {
                case "Drinks":
                    if dish.image == [] {
                        var counter: Double = 0
                        var total: Double = 0
                        for rating in dish.review {
                            total += rating.0
                            counter += 1
                        }
                        drinkArray.append((dish.dishName, "", total/counter))
                        continue
                    } else {
                        var counter: Double = 0
                        var total: Double = 0
                        for rating in dish.review {
                            total += rating.0
                            counter += 1
                        }
                        drinkArray.append((dish.dishName, dish.image[0], total/counter))
                    }
                    continue
                case "Appetizers":
                    if dish.image == [] {
                        var counter: Double = 0
                        var total: Double = 0
                        for rating in dish.review {
                            total += rating.0
                            counter += 1
                        }
                        
                        appetizerArray.append((dish.dishName, "", total/counter))
                        continue
                    } else {
                        var counter: Double = 0
                        var total: Double = 0
                        for rating in dish.review {
                            total += rating.0
                            counter += 1
                        }
                        appetizerArray.append((dish.dishName, dish.image[0], total/counter))
                    }
                    continue
                case "Dessert":
                    if dish.image == [] {
                        var counter: Double = 0
                        var total: Double = 0
                        for rating in dish.review {
                            total += rating.0
                            counter += 1
                        }
                        
                        dessertArray.append((dish.dishName, "", total/counter))
                        continue
                    } else {
                        var counter: Double = 0
                        var total: Double = 0
                        for rating in dish.review {
                            total += rating.0
                            counter += 1
                        }
                        dessertArray.append((dish.dishName, dish.image[0], total/counter))
                    }
                    continue
                default:
                    if dish.image == [] {
                        var counter: Double = 0
                        var total: Double = 0
                        for rating in dish.review {
                            total += rating.0
                            counter += 1
                        }
                        
                        mainArray.append((dish.dishName, "", total/counter))
                        continue
                    } else {
                        var counter: Double = 0
                        var total: Double = 0
                        for rating in dish.review {
                            total += rating.0
                            counter += 1
                        }
                        mainArray.append((dish.dishName, dish.image[0], total/counter))
                    }
                    continue
                }
            }
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if (tableView == self.mainTable)
            {
                return mainArray.count
            }else if(tableView == self.dessertTable)
            {
                return dessertArray.count
            }else if(tableView == self.drinksTable)
            {
                //print(drinkArray.count)
                return drinkArray.count
            }else if (tableView == self.appetizerTable)
            {
                return appetizerArray.count
            }
            
            return 0
          //  return mainArray.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if (tableView == self.mainTable){
                let cell = tableView.dequeueReusableCell(withIdentifier: "mainTableCell", for: indexPath) as! MenuPageTableViewCell
                cell.name = mainArray[indexPath.item].0
                self.mainTable.separatorColor = UIColor.clear
                return cell
            }else if (tableView == self.appetizerTable){
                let cell = tableView.dequeueReusableCell(withIdentifier: "apptizerTableCell", for: indexPath) as! MenuPageTableViewCell
                cell.name = appetizerArray[indexPath.item].0
                self.appetizerTable.separatorColor = UIColor.clear
                return cell
            }else if (tableView == self.dessertTable){
                let cell = tableView.dequeueReusableCell(withIdentifier: "dessertTableCell", for: indexPath) as! MenuPageTableViewCell
                cell.name = dessertArray[indexPath.item].0
                self.dessertTable.separatorColor = UIColor.clear
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "drinkTableCell", for: indexPath) as! MenuPageTableViewCell
                cell.name = drinkArray[indexPath.item].0
                self.drinksTable.separatorColor = UIColor.clear
                return cell
            }
        }

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if (tableView == self.mainTable){
                self.dishFinder = mainArray[indexPath.row].0
                performSegue(withIdentifier: "dishProfile", sender:self)
                
            }else if (tableView == self.appetizerTable){
 
                self.dishFinder = appetizerArray[indexPath.row].0
                performSegue(withIdentifier: "dishProfile", sender:self)
                
            }else if (tableView == self.dessertTable){
                self.dishFinder = dessertArray[indexPath.row].0
                performSegue(withIdentifier: "dishProfile", sender:self)
            }else{

                self.dishFinder = drinkArray[indexPath.row].0
                performSegue(withIdentifier: "dishProfile", sender:self)
            }
        }
}
