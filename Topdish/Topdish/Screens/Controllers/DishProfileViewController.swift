//
//  DishProfileViewController.swift
//  Topdish
//
//  Created by Gary Li on 11/24/19.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Kingfisher

class DishProfileViewController: UIViewController, UICollectionViewDelegate,UITableViewDelegate{
    

    var images = [UIImage(named: "Burger.png"), UIImage(named: "flatbread.png"), UIImage(named: "steak.png")]
    //var clickedDish:Menu = Menu()
    
    var storageImages: [UIImage] = []
    

    
    @IBOutlet weak var DishNameLabel: UILabel?
    @IBOutlet weak var dishTableView: UITableView!
    @IBOutlet weak var dishDetail: UICollectionView!

   
    var menu:[(Double,String)] = []

 
    override func viewDidLoad() {
        super.viewDidLoad()


        self.dishDetail.showsHorizontalScrollIndicator = false
        self.dishDetail.delegate = self
        self.dishDetail.dataSource = self
        self.dishDetail.decelerationRate = UIScrollView.DecelerationRate.fast
     

        
        self.dishTableView.dataSource = self
        self.dishTableView.delegate = self
        //  self.dishTableView.allowsSelection = true
        dishTableView.estimatedRowHeight = 85.0
        dishTableView.rowHeight = UITableView.automaticDimension
        
        getStorageImages()

        
    }
    
    func getStorageImages(){
        
    }



}

extension DishProfileViewController: UITableViewDataSource{
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "review", for: indexPath) as! DishReviewTableViewCell
      //  cell.review = "sda"
        cell.rate = menu[indexPath.row]
        
        //Remove the lines inbetween cells
        self.dishTableView.separatorColor = UIColor.clear
        
        return cell
    }
    
    
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
        print("AAAAAAAAAAAAAAAAAAAAAAA \(indexPath.item)")
        cell.menu = images[indexPath.item]
        //}
        cell.imagesView.image = images[indexPath.item]
     //   cell.backgroundColor = UIColor.red
        return cell
    }



}
    
  


