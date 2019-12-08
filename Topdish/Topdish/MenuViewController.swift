//
//  MenuViewController.swift
//  Topdish
//
//  Created by Gary Li on 11/24/19.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import UIKit
import FirebaseDatabase

class MenuViewController: UIViewController {

    @IBOutlet weak var dishView: UITableView!
    var dishes: [String] = []
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var MainDishCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*var i = 0
        Database.database().reference().child("menu").observeSingleEvent(of: .value, with: {(snapshot) in for rest in snapshot.children.allObjects as! [DataSnapshot] {print("Name: \(rest.key)")
           // self.nameLabel.text = rest.key
            self.restNames.append( rest.key)
           i = i + 0
            }
            self.nameLabel.text = self.restNames[0]
        })*/
        let childString : String = "menu/" + "Jaskaran's Kitchen"
        Database.database().reference().child(childString).observe(.value, with: {snapshot in
            if snapshot.exists() {
                for a in ((snapshot.value as AnyObject).allKeys)!{
                    self.dishes.append(a as! String)
                }
            }else{
                print("DNE")
            }
            print(self.dishes)
        })
        
      /*  Menu.getMenu(restaurant: "Jaskaran's Kitchen", completion: { myVal in
                   DispatchQueue.main.async {
                       print("Printerrrr \(myVal)")
                   }
               })*/
        // Do any additional setup after loading the view.
        
        // print("asdas \(restNames)")

        MainDishCollectionView.showsVerticalScrollIndicator = false
        self.dishView.reloadData()
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dishes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "dishIdentifier", for: indexPath)

           // Configure the cell...

           let test = dishes[indexPath.row]
    //       print("test \(test)")
           cell.textLabel?.text = test
           cell.detailTextLabel?.text = "sdamlk"
           return cell
       }
}

/*extension MenuViewController: UICollectionViewDataSource {
    /* Populating top restaurants to be used for horizontal collection view */
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          
          /* Sets up collection view for Top Places */
          if collectionView == self.MainDishCollectionView {
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCollectionCell", for: indexPath) as! HomePageCollectionCell
              let restaurant = topRestaurants[indexPath.item]
              cell.restaurant = restaurant

              return cell
}
*/
