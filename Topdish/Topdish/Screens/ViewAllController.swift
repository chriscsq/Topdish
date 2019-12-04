//
//  ViewAllController.swift
//  Topdish
//
//  Created by Chris Chau on 2019-12-02.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import UIKit

class ViewAllController: UIViewController, UICollectionViewDelegate {
    
    var nameFromHomePage = ""
    var givenRestaurants: [Restaurant] = []
    var clickedRestaurant: Restaurant = Restaurant()
    
    
    @IBOutlet weak var CollectionView: UICollectionView!
    @IBOutlet weak var PageLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        PageLabel.text = nameFromHomePage
        CollectionView.dataSource = self
        CollectionView.showsHorizontalScrollIndicator = false
        CollectionView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "restaurantSegue" {
            let dest = segue.destination as! RestaurantScreenController
            dest.restaurantName = clickedRestaurant.title
            //dest.RestaurantImages = clickedRestaurant.featuredImage!
        }
    }
    
}

extension ViewAllController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return givenRestaurants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CollectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantCardCollectionCell", for: indexPath) as! RestaurantCardCollectionCell
        if (givenRestaurants.count != 0) {
            let restaurant = givenRestaurants[indexPath.item]
            cell.restaurant = restaurant
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath) {
              
        if (collectionView == self.CollectionView) {
            let cell = collectionView.cellForItem(at: indexPath)  as! RestaurantCardCollectionCell

            print(cell)
            print(givenRestaurants[indexPath.row])
            self.clickedRestaurant = givenRestaurants[indexPath.row]
            performSegue(withIdentifier: "restaurantSegue", sender:self)

            }
    }
}
