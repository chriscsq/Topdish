//
//  ViewAllController.swift
//  Topdish
//
//  Created by Chris Chau on 2019-12-02.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import UIKit

class ViewAllController: UIViewController {
    
    var nameFromHomePage = ""
    var givenRestaurants:[Restaurant] = []
    
    @IBOutlet weak var CollectionView: UICollectionView!
    @IBOutlet weak var PageLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        PageLabel.text = nameFromHomePage
        CollectionView.dataSource = self
        CollectionView.showsHorizontalScrollIndicator = false


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

}
