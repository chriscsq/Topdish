//
//  MenuTableViewController.swift
//  Topdish
//
//  Created by Gary Li on 11/24/19.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import UIKit
import FirebaseDatabase

class MenuTableViewController: UITableViewController {
    
    var dishes: [String] = []
    var averageRating: [Double] = []
    var men = [Menu]()
    var m:Menu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
      
        getDish("Jaskaran's Kitchen")
       
        
    }
    
    /****
       Sending information to DishprofileViewController
     ***/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is DishProfileViewController
        {
           
            if let indexPath = tableView.indexPathForSelectedRow{
                let selectedRow = indexPath.row
              //  print("selceted \(men[selectedRow].dishTitle)")
                print("sdasda")
                let vc = segue.destination as! DishProfileViewController
                vc.menu = self.men[selectedRow]
            }
        }

   

        
    }

    
    /****
     Getting information from the database
     Get the dish name and calculate the average rating of the dish
     Also get the individual review and the rating 
     ***/
    func getDish(_ resturant: String){
        let childString : String = "menu/" + resturant
        var counter: Double = 0
        var totalRating: Double = 0
        var rating = [Double]()
        var userReview = [String]()
        var i = 0
        var description = "Database part"

        Database.database().reference().child(childString).observe(.value, with: {snapshot in
            if snapshot.exists() {
                for a in ((snapshot.value as AnyObject).allKeys)!{
                    self.dishes.append(a as! String)
                }
                self.dishes.reverse()
                
                let singleRestaurant = snapshot.children
    
                while let dishes = singleRestaurant.nextObject() as? DataSnapshot {
                    let dishReviews = (dishes.childSnapshot(forPath: "user reviews")).children
                    while let review = dishReviews.nextObject() as? DataSnapshot {
                        let singleRating = review.childSnapshot(forPath: "rating").value
                        
                        totalRating += (singleRating as AnyObject).doubleValue
                        counter += 1
                        let singleTextReview = review.childSnapshot(forPath: "text review").value
                        userReview.append(singleTextReview as! String)
                        rating.append(singleRating as! Double)
                        
                    }
                    
                 //   self.m = Menu(self.dishes[i], UIImage(named: "steak.png")!, rating, userReview, description)
                    self.men.append(self.m!)
                    self.averageRating.append(totalRating/counter)
                   
    
                    //reseting
                    totalRating = 0
                    counter = 0
                    rating = [Double]()
                    userReview = [String]()
                    i = i + 1
                }

                
            }else{
                print("DNE")
            }
            self.tableView.reloadData()
        })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dishes.count
    }


    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dishIdentifier", for: indexPath)

        // Configure the cell...
        let i = indexPath.row
        //print("sdada \(i) \(dishes[i]) \(averageRating[i])")
        
        cell.textLabel?.text = dishes[i]
        cell.detailTextLabel?.text = "Average Rating: \(String(averageRating[i]))"
        return cell
    }
    func getIndex(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) -> Int
    {
               print("selected \(indexPath.row)")
        return indexPath.row
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
