//
//  RestaurantScreenController.swift
//  Topdish
//
//  Created by Chris Chau on 2019-12-03.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import UIKit

class RestaurantScreenController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet var ImageCollectionView: UICollectionView!
    var restaurantName = ""
        
    @IBOutlet var RestaurantNameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        RestaurantNameLabel.text = restaurantName
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
       
    /*
       func collectionView(_ collectionView: UICollectionView,
       didSelectItemAt indexPath: IndexPath) {
           
           print("hello")
           if (collectionView == self.TopPlacesCollectionView) {
               let cell = collectionView.cellForItem(at: indexPath)  as! HomePageCollectionCell

               print(cell)
               print(topRestaurants[indexPath.row])
               self.clickedRestaurant = topRestaurants[indexPath.row]
               performSegue(withIdentifier: "restaurantSegue", sender:self)

           } else if (collectionView == self.NearbyCollectionView) {
               let cell = collectionView.cellForItem(at: indexPath)  as! HomePageCollectionCell

               print(cell)

               print(nearbyRestaurants[indexPath.row])
               self.clickedRestaurant = nearbyRestaurants[indexPath.row]
               performSegue(withIdentifier: "restaurantSegue", sender:self)

           } else if (collectionView == self.ExclusiveOffersCollectionView) {
               let cell = collectionView.cellForItem(at: indexPath)  as! HomePageCollectionCell

               print(cell)

               print(exclusiveOffersRestaurants[indexPath.row])
               self.clickedRestaurant = exclusiveOffersRestaurants[indexPath.row]
               performSegue(withIdentifier: "restaurantSegue", sender:self)

           }
       }
 */
}
    
