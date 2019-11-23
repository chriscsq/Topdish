//
//  HomePageController.swift
//  Topdish
//
//  Created by Chris Chau on 2019-11-22.
//  Copyright © 2019 Topdish Inc. All rights reserved.
// Icons made by https://www.flaticon.com/authors/freepik from https://www.flaticon.com
//

import UIKit

class HomePageController: UIViewController {

    /* Labels */
    @IBOutlet weak var HomeLabel: UILabel!
    
    @IBOutlet weak var TopPlacesCollectionView: UICollectionView!
    @IBOutlet weak var NearbyCollectionView: UICollectionView!
    @IBOutlet weak var ExclusiveOffersCollectionView: UICollectionView!
    
    
    var topRestaurants = Restaurant.getTopPlaces()
    var nearbyRestaurants = Restaurant.getNearby()
    var exclusiveOffersRestaurants = Restaurant.getExclusiveOffers()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Restaurant.getRating(resturant: "Jaskaran's Kitchen"))
        
        // Do any additional setup after loading the view.
        TopPlacesCollectionView.dataSource = self
        TopPlacesCollectionView.showsHorizontalScrollIndicator = false
        
        NearbyCollectionView.dataSource = self
        NearbyCollectionView.showsHorizontalScrollIndicator = false
        
        ExclusiveOffersCollectionView.dataSource = self
        ExclusiveOffersCollectionView.showsHorizontalScrollIndicator = false
    }

}

extension HomePageController: UICollectionViewDataSource {

    func numberOfSections(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.TopPlacesCollectionView {
            return topRestaurants.count
        } else if collectionView == self.NearbyCollectionView {
            return nearbyRestaurants.count
        }
        return exclusiveOffersRestaurants.count
    }

    /* Populating top restaurants to be used for horizontal collection view */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        /* Sets up collection view for Top Places */
        if collectionView == self.TopPlacesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomePageCollectionCell", for: indexPath) as! HomePageCollectionCell
            let restaurant = topRestaurants[indexPath.item]
            cell.restaurant = restaurant

            return cell
            
        /* Sets up collection view for Nearby */
        } else if collectionView == self.NearbyCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomePageCollectionCell", for: indexPath) as! HomePageCollectionCell
            let restaurant = nearbyRestaurants[indexPath.item]
            cell.restaurant = restaurant
            return cell
        }
        
        /* Sets up collection view for Exclusive Offers*/
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomePageCollectionCell", for: indexPath) as! HomePageCollectionCell
        let restaurant = exclusiveOffersRestaurants[indexPath.item]
        cell.restaurant = restaurant
        return cell
    }
}

