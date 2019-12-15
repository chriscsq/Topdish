//
//  RestaurantScreenController.swift
//  Topdish
//
//  Created by Chris Chau on 2019-12-03.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import UIKit
import Cosmos

class RestaurantScreenController: UIViewController, UICollectionViewDelegate, UITableViewDelegate {
    
    @IBOutlet weak var starView: CosmosView!
    var clickedRestaurant: Restaurant = Restaurant()
    var restaurantImage: UIImage?
    var restaurantImageView: UIImageView?
    var menu: [String] = []
    var reviews: [String] = []
    // MARK: Label variables
    var restaurantName = ""
    var dishFinder = ""
    var hourMon = "", hourTue = "", hourWed = "",
        hourThu = "", hourFri = "", hourSat = "", hourSun = ""
    var street = "", postal = "", city = ""
    var address = ""
    var phone  = ""
    var foodRatingLabel = "Food"
    var serviceRatingLabel = "Service"
    var rating: Double = 0.0
    
    var res:Restaurant!

    // MARK: IBOutlets
    @IBOutlet weak var RestaurantImageView: UIImageView!
    @IBOutlet var AddReviewButton: UIButton!
    @IBOutlet var RestaurantNameLabel: UILabel!
    @IBOutlet var ViewSegmentedController: UISegmentedControl!
    @IBOutlet weak var ReviewsView: UIView!
    @IBOutlet weak var DishesView: UIView!
    @IBOutlet weak var TopDishesTableView: UITableView!
    @IBOutlet weak var ReviewTableView: UITableView!
    
    @IBOutlet weak var StreetLabel: UILabel!
    @IBOutlet weak var PhoneLabel: UILabel!
    
    @IBOutlet weak var MonTime: UILabel!
    @IBOutlet weak var TueTime: UILabel!
    @IBOutlet weak var WedTime: UILabel!
    @IBOutlet weak var ThuTime: UILabel!
    @IBOutlet weak var FriTime: UILabel!
    @IBOutlet weak var SatTime: UILabel!
    @IBOutlet weak var SunTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RestaurantNameLabel.text = restaurantName
        RestaurantImageView.image = restaurantImage
        
        DishesView.isHidden = false
        ReviewsView.isHidden = true
        TopDishesTableView.dataSource = self
        ReviewTableView.dataSource = self
        TopDishesTableView.delegate = self
        
        /*
        setupTime()
        setupAddress()
        setupPhone()
        */
        ReviewTableView.estimatedRowHeight = 44.0
        ReviewTableView.rowHeight = UITableView.automaticDimension

        
        MonTime.text = hourMon
        TueTime.text = hourTue
        WedTime.text = hourWed
        ThuTime.text = hourThu
        FriTime.text = hourFri
        SatTime.text = hourSat
        SunTime.text = hourSun
        StreetLabel.text = address
        PhoneLabel.text = phone
        starView.rating = self.rating

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
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "dishSegue" {
            let nav = segue.destination as! UINavigationController
            let svc = nav.topViewController as! MultiViewController
            svc.menu = res.menu
        }
        if segue.identifier == "dishProfileSegue"{
            print("hehehe", clickedRestaurant.menu.dishes)
//            let storyboard: UIStoryboard = UIStoryboard(name: "Homepage", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "DishProfileViewController") as! DishProfileViewController
            
            let svc = segue.destination as! DishProfileViewController
            print("sdadada")
            for i in res.menu.dishes{
                print("sdasdasdfkidsjfos",i.dishName)
                if (i.dishName == dishFinder){
                    print("seaguing \(i.review)")
                    svc.menu = i.review
                    print("I want to leave")
                   // self.show(vc, sender: self)
                    break;
                }
            }
        }
    }}

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
          //  print(menu[indexPath.item])
            cell.review = review
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(tableView == self.TopDishesTableView){
                self.dishFinder = menu[indexPath.row]
            print("asfdsklfjmskl",dishFinder)
                    performSegue(withIdentifier: "dishProfileSegue", sender:self)
        }
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
