//
//  NearbyViewController.swift
//  Topdish
//
//  Created by Chris Chau on 2019-12-08.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import UIKit
import MapKit

class NearbyViewController: UIViewController, UICollectionViewDelegate {
    var locationManager = CLLocationManager()

    @IBOutlet weak var DraggedView: UIView!
    @IBOutlet weak var DragBar: UIView!
    @IBOutlet weak var MapView: MKMapView!
    @IBOutlet weak var NearbyCollectionView: UICollectionView!
    var clickedRestaurant: Restaurant = Restaurant()

    var nearbyRestaurants: [Restaurant] = [] {
        didSet{
            NearbyCollectionView.reloadData()
        }
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        nearby()
        NearbyCollectionView.delegate = self
        NearbyCollectionView.dataSource = self
        NearbyCollectionView.showsHorizontalScrollIndicator = false

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        MapView.showsUserLocation = true
        
        /* Styling of bar */
        DragBar.layer.cornerRadius = 5
        DragBar.layer.masksToBounds = true
        DragBar.layer.shadowColor = UIColor.black.cgColor
        DragBar.layer.shadowOpacity = 1
        DragBar.layer.shadowOffset = .zero
        DragBar.layer.shadowRadius = 10


        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        
        swipeUp.direction = .up
        swipeDown.direction = .down

        DraggedView.addGestureRecognizer(swipeUp)
        DraggedView.addGestureRecognizer(swipeDown)

        
        // Check for Location Services
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
        }

        //Zoom to user location
        if let userLocation = locationManager.location?.coordinate {
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: userLocation, span: span)
            MapView.setRegion(region, animated: false)
        }

        /*
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipes))
        DraggedView.addGestureRecognizer(gesture)
 */
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "restaurantSegue" {
            let dest = segue.destination as! RestaurantScreenController
            dest.restaurantName = clickedRestaurant.title
            dest.restaurantImage = clickedRestaurant.featuredImage!
        }
    }
    
    @objc func handleSwipes(_ gesture: UISwipeGestureRecognizer) {
        print("hello")
        let view = gesture.view!
        switch gesture.direction {
        case .up:
            UIView.animate(withDuration: 0.3, animations: {
                self.MapView.alpha = 0.5
                view.center = CGPoint(x: view.center.x, y: 667)
            })
        case .down:
            UIView.animate(withDuration:0.3, animations: {
                self.MapView.alpha = 1
                view.center = CGPoint(x: view.center.x, y: 1098)
            })
        default:
            break
        }
    }
    /*
    @objc func wasDragged(gesture: UISwipe) {
        let fileView = gesture.view!
        let translation = gesture.translation(in: self.view)

        switch gesture.state {
            
        case .began, .changed:
            
            fileView.center = CGPoint(x: fileView.center.x, y: fileView.center.y + translation.y)
            gesture.setTranslation(CGPoint.zero, in: view)
        case .ended:
            
            if fileView.frame.contains(CGPoint(x: fileView.center.x, y: 778.5)) {
                UIView.animate(withDuration: 0.3 , animations: {
                    self.MapView.alpha = 1
                    fileView.center = CGPoint(x: fileView.center.x, y: 1097)
                })
            } else if fileView.frame.contains(CGPoint(x: fileView.center.x, y: fileView.center.y - 50)) {
                //fileView.center.y - 50
                UIView.animate(withDuration: 0.3 , animations: {
                    self.MapView.alpha = 0.5
                    fileView.center = CGPoint(x: fileView.center.x, y: 667)
                })
            }
        
        default:
            break
        }
    }
 */
    
    func nearby() -> Void {
        if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() ==  .authorizedAlways) {
            guard let locValue: CLLocationCoordinate2D = locationManager.location?.coordinate else { return }
                print("locations = \(locValue.latitude) \(locValue.longitude)")
                nearbyPlaces(location: locValue)
        } else {
            print("We have no access to the phones location.")
            Restaurant.getRestaurantList(complete: { restaurantArray in
            self.nearbyRestaurants = restaurantArray
            DispatchQueue.main.async {
            self.NearbyCollectionView.reloadData()
            }
        })
        }
    }
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



extension NearbyViewController : CLLocationManagerDelegate {
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            MapView.setRegion(region, animated: true)
        }
    }

    private func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("error:: (error)")
    }
    
    func locationManager(_ manager: CLLocationManager,
    didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }


}

extension NearbyViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nearbyRestaurants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = NearbyCollectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantCell", for: indexPath) as! RestaurantCardCollectionCell
        let restaurant = nearbyRestaurants[indexPath.item]
        cell.restaurant = restaurant
        return cell
    }
    /* On click of collection cell*/
    func collectionView(_ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath) {
        self.clickedRestaurant = nearbyRestaurants[indexPath.row]
        performSegue(withIdentifier: "restaurantSegue", sender:self)
    }
    
    func nearbyPlaces(location: CLLocationCoordinate2D) -> Void {
        Restaurant.getNearby(location: location, complete: { restaurantArray in
            self.nearbyRestaurants = restaurantArray
        })
    }

}
