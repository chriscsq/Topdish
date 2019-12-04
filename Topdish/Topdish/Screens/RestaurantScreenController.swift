//
//  RestaurantScreenController.swift
//  Topdish
//
//  Created by Chris Chau on 2019-12-03.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import UIKit

class RestaurantScreenController: UIViewController, UICollectionViewDelegate {
    
    
    var clickedRestaurant: Restaurant = Restaurant()
    @IBOutlet var ImageCollectionView: UICollectionView!
    var restaurantName = ""
        
    @IBOutlet var RestaurantNameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        RestaurantNameLabel.text = restaurantName
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "restaurantSegue" {
            let dest = segue.destination as! RestaurantScreenController
            dest.restaurantName = clickedRestaurant.title
            //dest.RestaurantImages = clickedRestaurant.featuredImage!
        }
    }

}


extension RestaurantScreenController: UICollectionViewDataSource {

       func numberOfSections(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return 1
       }
       

       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 1
       }

       /* Populating top restaurants to be used for horizontal collection view */
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           
        
           return UICollectionViewCell()
       }
       

}
    
