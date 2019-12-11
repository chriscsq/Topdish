//
//  DishProfileViewController.swift
//  Topdish
//
//  Created by Gary Li on 11/24/19.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import UIKit
import FirebaseDatabase

class DishProfileViewController: UIViewController, UICollectionViewDelegate,UITableViewDelegate{
    

    var images = [UIImage(named: "Burger.png"), UIImage(named: "flatbread.png"), UIImage(named: "steak.png")]
    //var clickedDish:Menu = Menu()
    

    
    @IBOutlet weak var dishTableView: UITableView!
      @IBOutlet weak var dishDetail: UICollectionView!


    var menu:Menu?

 
    override func viewDidLoad() {
        super.viewDidLoad()

       //trying to make the animation on the circle
       // addCircleView()
    


//        if let dish = menu{
//            dishLabel?.text = dish.dishTitle
//            dishImage.image = dish.dishImage
//            descriptionLabel?.text = dish.description

//       }else{
//           print("else")
//            dishLabel?.text = nil
//            dishImage.image = nil
//        }

        self.dishDetail.showsHorizontalScrollIndicator = false
        self.dishDetail.delegate = self
        self.dishDetail.dataSource = self
        dishDetail.reloadData()
        self.dishDetail.decelerationRate = UIScrollView.DecelerationRate.fast
     

        
        self.dishTableView.dataSource = self
       self.dishTableView.delegate = self
        self.dishTableView.allowsSelection = true
        dishTableView.estimatedRowHeight = 85.0
        dishTableView.rowHeight = UITableView.automaticDimension

        
    }
    func addCircleView() {
        let diceRoll = CGFloat(Int(arc4random_uniform(7))*50)
        let circleWidth = CGFloat(200)
        let circleHeight = circleWidth

            // Create a new CircleView
        let circleView = CreateCircle(frame: CGRect(x: diceRoll, y: 0, width: circleWidth, height: circleHeight))

         view.addSubview(circleView)

         // Animate the drawing of the circle over the course of 1 second
        circleView.animateCircle(duration: 10.0)
    }

  /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
//        if segue.identifier == "reviewIdentitifer"
//        {
//            print("sadasdas")
//            var vc = segue.destination as! DishProfileViewController
//           // print("rrr \(r)")
//           // m = men[r]
//            vc.menu = menu
//        }
    }
    */


}

extension DishProfileViewController: UITableViewDataSource{
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1//(menu?.userReview.count)!
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "review", for: indexPath) as! DishReviewTableViewCell
//        cell.review = menu?.userReview[indexPath.row]
//        cell.rate = menu?.rating[indexPath.row]
        
        //Remove the lines inbetween cells
        self.dishTableView.separatorColor = UIColor.clear
        
        return cell
    }
    
//   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//         print("You tapped cell number \(indexPath.row).")
//     }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("row")
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print("row")
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         if segue.destination is ReviewViewController
//         {
//
//             if let indexPath = dishTableView.indexPathForSelectedRow{
//                 let selectedRow = indexPath.row
//                 let vc = segue.destination as! ReviewViewController
//                vc.review = menu?.userReview[selectedRow]
//             }
//         }
//
//    }
    
}

extension DishProfileViewController: UICollectionViewDataSource{


    
    func numberOfSections(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("testestetestsetes \(images.count)")
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewIdentifier", for: indexPath) as! DishDetailCollectionViewCell
      //  for i in images{
        cell.menu = images[indexPath.item]
        //}
        cell.imagesView.image = images[indexPath.item]
     //   cell.backgroundColor = UIColor.red
        return cell
    }



}
    
  


