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
    
    
    var nearbyRestaurants: [Restaurant] = [] {
        didSet{
            TopPlacesCollectionView.reloadData()
        }
    }
    var exclusiveOffersRestaurants: [Restaurant] = [] {
        didSet{
            ExclusiveOffersCollectionView.reloadData()
        }
    }
    var topRestaurants: [Restaurant] = []{
        didSet{
            NearbyCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //print(Restaurant.getRating(restaurant: "Jaskaran's Kitchen"))
        Restaurant.getRating(restaurant: "Jaskaran's Kitchen", completion: { myVal in
            DispatchQueue.main.async {
                print(myVal)
            }
        })
        
        getTopPlaces()
        getNearbyRestaurants()
        getExclusiveOffers()
    
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
    
    func getTopPlaces() -> Void {
        Restaurant.getRestaurantList(complete: { restaurantArray in
            self.topRestaurants = restaurantArray
            self.sortByRating()
        })
    }
    func getNearbyRestaurants() -> Void {
        Restaurant.getRestaurantList(complete: { restaurantArray in
            self.nearbyRestaurants = restaurantArray
        })
    }
    func getExclusiveOffers() -> Void {
        Restaurant.getRestaurantList(complete: { restaurantArray in
            self.exclusiveOffersRestaurants = restaurantArray
        })
    }
    
    /* Used by getTopPlaces, will sort topRestaurants by highest rating */
    func sortByRating() -> Void {
        topRestaurants = topRestaurants.sorted { $0.rating > $1.rating}
        for restaurant in topRestaurants {
            print("Rest order: ", restaurant.title, "rating: ", restaurant.rating)
        }
        DispatchQueue.main.async {
            self.TopPlacesCollectionView.reloadData()
        }
    }

    func numberOfSections(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func comp(number: Double) -> Void {
        print(number)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == self.TopPlacesCollectionView) {
            print("1")
            return nearbyRestaurants.count
        } else if (collectionView == self.NearbyCollectionView) {
            print("2")
            return nearbyRestaurants.count
        } else if (collectionView == self.ExclusiveOffersCollectionView) {
            print("3")
            return exclusiveOffersRestaurants.count
        }
        return 0
    }

    /* Populating top restaurants to be used for horizontal collection view */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        /* Sets up collection view for Top Places */
        if (collectionView == self.TopPlacesCollectionView) {
            let cell = TopPlacesCollectionView.dequeueReusableCell(withReuseIdentifier: "HomePageCollectionCell", for: indexPath) as! HomePageCollectionCell
            //print("length", topRestaurants.count)
            if (topRestaurants.count != 0) {
                let restaurant = topRestaurants[indexPath.item]
                cell.restaurant = restaurant
                return cell
            }
        /* Sets up collection view for Nearby */
        } else if (collectionView == self.NearbyCollectionView) {
            print("nearby collection view")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomePageCollectionCell", for: indexPath) as! HomePageCollectionCell
            if (nearbyRestaurants.count != 0) {
                let restaurant = nearbyRestaurants[indexPath.item]
                cell.restaurant = restaurant
                return cell
            }
        } else if (collectionView == self.ExclusiveOffersCollectionView) {
            print("else collection view")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomePageCollectionCell", for: indexPath) as! HomePageCollectionCell
            let restaurant = exclusiveOffersRestaurants[indexPath.item]
            cell.restaurant = restaurant
            return cell
        }
 
        return UICollectionViewCell()
    }
}

