//
//  NearMeCollectionView.swift
//  Topdish
//
//  Created by Chris Chau on 2019-11-26.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import UIKit

class NearbyCollectionView: UICollectionViewCell {
    
    @IBOutlet weak var NearbyCollectionView: UICollectionView!

    var nearbyRestaurants: [Restaurant] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getNearbyRestaurants()

        NearbyCollectionView.dataSource = self
        NearbyCollectionView.showsHorizontalScrollIndicator = false
    }
}


extension HomePageController: UICollectionViewDataSource {
    
    func getNearbyRestaurants() -> Void {
        Restaurant.getRestaurantList(complete: { restaurantArray in
            self.nearbyRestaurants = restaurantArray
        })
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nearbyRestaurants.count
    }

    /* Populating top restaurants to be used for horizontal collection view */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        print("topplaces collection view")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomePageCollectionCell", for: indexPath) as! HomePageCollectionCell
        //print("length", topRestaurants.count)
        if (nearbyRestaurants.count != 0) {
            let restaurant = nearbyRestaurants[indexPath.item]
            cell.restaurant = restaurant
            return cell
        }
        return UICollectionViewCell()
    }
}


