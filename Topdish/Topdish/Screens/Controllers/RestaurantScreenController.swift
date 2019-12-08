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
    var restaurantImage: UIImage?
    var restaurantImageView: UIImageView?
    var menu: [String] = []
    var reviews: [String] = []
    // MARK: Label variables
    var restaurantName = ""
    var hourMon = "", hourTue = "", hourWed = "",
        hourThur = "", hourFri = "", hourSat = "", hourSun = ""
    var street = "", postal = "", city = ""
    var phone  = ""
    var foodRatingLabel = "Food"
    var serviceRatingLabel = "Service"

    // MARK: IBOutlets
    @IBOutlet weak var RestaurantImageView: UIImageView!
    @IBOutlet var PhoneLabel: UILabel!
    @IBOutlet var StreetLabel: UILabel!
    @IBOutlet var AddReviewButton: UIButton!
    @IBOutlet var RestaurantNameLabel: UILabel!
    @IBOutlet var ViewSegmentedController: UISegmentedControl!
    @IBOutlet weak var ReviewsView: UIView!
    @IBOutlet weak var DishesView: UIView!
    @IBOutlet weak var TopDishesTableView: UITableView!
    @IBOutlet weak var ReviewTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RestaurantNameLabel.text = restaurantName
        RestaurantImageView.image = restaurantImage
        
        DishesView.isHidden = false
        ReviewsView.isHidden = true
        street = "4004 3rd st nw \nCalgary, AB \nT2k 0Z8"
        StreetLabel.text = street
        TopDishesTableView.dataSource = self
        ReviewTableView.dataSource = self
        
        ReviewTableView.estimatedRowHeight = 44.0
        ReviewTableView.rowHeight = UITableView.automaticDimension

    }
    
    @IBAction func changeViewOnSegment(_ sender: Any) {
        switch ViewSegmentedController.selectedSegmentIndex {
        case 0:
            DishesView.isHidden = false
            ReviewsView.isHidden = true
        case 1:
            DishesView.isHidden = true
            ReviewsView.isHidden = false
        default:
            DishesView.isHidden = false
            ReviewsView.isHidden = true
        }
    }
    
}

extension RestaurantScreenController:  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /* Only show maximum of 5 cells */
        if (tableView == TopDishesTableView) {
            if (menu.count < 10) {
                return menu.count
            }
            return 10
        } else if (tableView == ReviewTableView) {
            return reviews.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView == TopDishesTableView) {
            let cell = TopDishesTableView.dequeueReusableCell(withIdentifier: "DishCell", for: indexPath) as! TopDishesTableViewCell
            let dish = menu[indexPath.item]
            print(menu[indexPath.item])
            cell.dishName = dish
            return cell
        } else if (tableView == ReviewTableView) {
            let cell = ReviewTableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewTableViewCell
            let review = reviews[indexPath.item]
            print(menu[indexPath.item])
            cell.review = review
            return cell
        }
        return UITableViewCell()
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
