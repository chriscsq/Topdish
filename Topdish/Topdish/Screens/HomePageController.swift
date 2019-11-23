//
//  HomePageController.swift
//  Topdish
//
//  Created by Chris Chau on 2019-11-22.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import UIKit

class HomePageController: UIImagePickerController {

    /* Labels */
    @IBOutlet weak var HomeLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var restaurants = Restaurant.fetchRestaurants()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
    }

}

extension HomePageController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurants.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomePageCollectionCell", for: indexPath) as! HomePageCollectionCell
        let restaurant = restaurants[indexPath.item]
        
        cell.restaurant = restaurant
        
        return cell
    }
}
