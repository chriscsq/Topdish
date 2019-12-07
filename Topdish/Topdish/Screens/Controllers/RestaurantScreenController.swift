//
//  RestaurantScreenController.swift
//  Topdish
//
//  Created by Chris Chau on 2019-12-03.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import UIKit

class RestaurantScreenController: UIViewController, UICollectionViewDelegate {
    
    var restaurantName = ""
    var clickedRestaurant: Restaurant = Restaurant()
    var restaurantImages: [UIImage] = []
    var testArray:[UIImage] = [UIImage(named: "steak")!]
    @IBOutlet var AddReviewButton: UIButton!
    @IBOutlet var RestaurantNameLabel: UILabel!
    @IBOutlet var ImageCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RestaurantNameLabel.text = restaurantName
        print(testArray.count)
        print(restaurantImages.count)
        ImageCollectionView.dataSource = self
       // ImageCollectionView.showsHorizontalScrollIndicator = false
        
    }


}


/* Used for when you click on pictures */
extension RestaurantScreenController: UICollectionViewDataSource {

       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 1
       }

       /* Populating collectionview  */
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = ImageCollectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantImageCollectionCell", for: indexPath) as! RestaurantImageCollectionCell
            let headerImage = testArray[indexPath.item]
            cell.headerImage.image = headerImage
            return cell
        
    }
       

}
    

@IBDesignable extension UIButton {

    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}
