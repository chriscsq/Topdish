//
//  HomePageController.swift
//  Topdish
//
//  Created by Chris Chau on 2019-11-22.
//  Copyright © 2019 Topdish Inc. All rights reserved.
// Icons made by https://www.flaticon.com/authors/freepik from https://www.flaticon.com
//

import UIKit
import CoreLocation

class HomePageController: UIViewController, UICollectionViewDelegate {

    var pageLabel = ""
    var restaurantList: [Restaurant] = []
    var locationManager: CLLocationManager?
    /* Labels */
    @IBOutlet weak var HomeLabel: UILabel!
    
    /* CollectionViews */
    @IBOutlet weak var TopPlacesCollectionView: UICollectionView!
    @IBOutlet weak var NearbyCollectionView: UICollectionView!
    @IBOutlet weak var ExclusiveOffersCollectionView: UICollectionView!
    
    /* View all buttons */
    @IBAction func TopPlacesViewAllButton(_ sender: Any) {
        pageLabel = "Top Places"
        restaurantList = topRestaurants
        performSegue(withIdentifier: "ViewAll", sender:self)
    }

    @IBAction func NearMeViewAllButton(_ sender: Any) {
        pageLabel = "Near Me"
        restaurantList = nearbyRestaurants
        performSegue(withIdentifier: "ViewAll", sender:self)
    }
    
    @IBAction func ExclusiveOffersViewAllButton(_ sender: Any) {
        pageLabel = "Exclusive Offers"
        restaurantList = exclusiveOffersRestaurants
        performSegue(withIdentifier: "ViewAll", sender:self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! ViewAllController
        dest.nameFromHomePage = pageLabel
        dest.givenRestaurants = restaurantList
    }
    
    /* Restaurant lists */
    var topRestaurants: [Restaurant] = [] {
        didSet{
           // self.sortByRating()
            TopPlacesCollectionView.reloadData()
        }
    }
    
    var nearbyRestaurants: [Restaurant] = [] {
        didSet{
            NearbyCollectionView.reloadData()
        }
    }
    var exclusiveOffersRestaurants: [Restaurant] = [] {
        didSet{
            ExclusiveOffersCollectionView.reloadData()
        }
    }

    /* View did load */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager?.startUpdatingLocation()
        
        topPlaces()
        nearby()
        getExclusiveOffers()
    
        // Do any additional setup after loading the view.
        TopPlacesCollectionView.delegate = self
        TopPlacesCollectionView.dataSource = self
        TopPlacesCollectionView.showsHorizontalScrollIndicator = false
        
        NearbyCollectionView.delegate = self
        NearbyCollectionView.dataSource = self
        NearbyCollectionView.showsHorizontalScrollIndicator = false
        
        ExclusiveOffersCollectionView.delegate = self
        ExclusiveOffersCollectionView.dataSource = self
        ExclusiveOffersCollectionView.showsHorizontalScrollIndicator = false
    }
    
}
extension HomePageController: CLLocationManagerDelegate {
    func nearby() -> Void {
        if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() ==  .authorizedAlways) {
            
            guard let locValue: CLLocationCoordinate2D = locationManager?.location?.coordinate else { return }
            print("locations = \(locValue.latitude) \(locValue.longitude)")
            nearbyPlaces(location: locValue)
            
        } else {
            print("We have no access to the phones location.")
            Restaurant.getRestaurantList(complete: { restaurantArray in
                self.topRestaurants = restaurantArray
                DispatchQueue.main.async {
                    self.NearbyCollectionView.reloadData()
                }
            })
        }
    }
}


extension HomePageController: UICollectionViewDataSource {
    
    func topPlaces() -> Void {
        Restaurant.getRestaurantList(complete: { restaurantArray in
            print("WE GET HERE")
            self.topRestaurants = restaurantArray
            self.sortByRating()
        })
    }
    func nearbyPlaces(location: CLLocationCoordinate2D) -> Void {
        Restaurant.getNearby(location: location, complete: { restaurantArray in
            self.nearbyRestaurants = restaurantArray
            DispatchQueue.main.async {
                self.NearbyCollectionView.reloadData()
            }
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
        print("////////")
        DispatchQueue.main.async {
            self.TopPlacesCollectionView.reloadData()
        }
    
    }

    func numberOfSections(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == self.TopPlacesCollectionView) {
            return topRestaurants.count
        } else if (collectionView == self.NearbyCollectionView) {
            return nearbyRestaurants.count
        } else if (collectionView == self.ExclusiveOffersCollectionView) {
            return exclusiveOffersRestaurants.count
        }
        return 0
    }

    /* Populating top restaurants to be used for horizontal collection view */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        /* Sets up collection view for Top Places */
        if (collectionView == self.TopPlacesCollectionView) {
            let cell = TopPlacesCollectionView.dequeueReusableCell(withReuseIdentifier: "HomePageCollectionCell", for: indexPath) as! HomePageCollectionCell
            if (topRestaurants.count != 0) {
                let restaurant = topRestaurants[indexPath.item]
                cell.restaurant = restaurant
                return cell
            }
            
        /* Sets up collection view for Nearby */
        } else if (collectionView == self.NearbyCollectionView) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomePageCollectionCell", for: indexPath) as! HomePageCollectionCell
            if (nearbyRestaurants.count != 0) {
                let restaurant = nearbyRestaurants[indexPath.item]
                cell.restaurant = restaurant
                return cell
            }
            
        /* Sets up collectionview for Exclusive Offers */
        } else if (collectionView == self.ExclusiveOffersCollectionView) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomePageCollectionCell", for: indexPath) as! HomePageCollectionCell
            let restaurant = exclusiveOffersRestaurants[indexPath.item]
            cell.restaurant = restaurant
            return cell
        }
 
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath) {
        
        print("hello")
        if (collectionView == self.TopPlacesCollectionView) {
            let cell = collectionView.cellForItem(at: indexPath)  as! HomePageCollectionCell

            print(cell)
            print(topRestaurants[indexPath.row])
        } else if (collectionView == self.NearbyCollectionView) {
            let cell = collectionView.cellForItem(at: indexPath)  as! HomePageCollectionCell

            print(cell)

            print(nearbyRestaurants[indexPath.row])
        } else if (collectionView == self.ExclusiveOffersCollectionView) {
            let cell = collectionView.cellForItem(at: indexPath)  as! HomePageCollectionCell

            print(cell)

            print(exclusiveOffersRestaurants[indexPath.row])

        }
    }

}

