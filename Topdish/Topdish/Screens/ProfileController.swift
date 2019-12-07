//
//  ProfileController.swift
//  Topdish
//
//  Created by Simran Bhattarai on 2019-11-26.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class ProfileController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var bookmarkreview = true
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let label = UILabel(frame: CGRect(x:0, y:0, width:200, height:50))
        //POPULATE TABLE FROM DB HERE
        //Add conditionals???
        if bookmarkreview{
            
            label.text = "Hello"
            
        }else{
            label.text = "Not Hello"
        }
        
        cell.addSubview(label)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    


    
   //Define variables
    @IBOutlet weak var CoverPhoto: UIImageView!
    @IBOutlet weak var Photo: UIImageView!
    @IBOutlet weak var nameField:UITextField!
    
    @IBOutlet weak var tablecontrol:UISegmentedControl!
    //These need to be connected to the DB
    @IBOutlet weak var numberofReview: UILabel!
    @IBOutlet weak var numberoflikeddishes:UILabel!
    
    @IBOutlet weak var Table: UITableView!
    let imagePicker = UIImagePickerController()
    //@IBOutlet weak override var bookmarked: UITabBarItem!
    
   // @IBOutlet weak override var reviews: UITabBarItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Make profile picture rounded
        Photo.makeRounded()
        //Use Person's entered name as default Text
        self.nameField.placeholder = "First Last"
        //Update Label based on the user profile here
    //self.numberofReview.text =
    //self.numberoflikeddishes.text =
        
        //Table view
        Table.dataSource = (self as UITableViewDataSource)
        Table.delegate = (self as UITableViewDelegate)
       
        
        
        
    }
    
    //Change profile picture
    @IBAction func loadImageButtonTapped(_ sender: UIButton) {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    //This is to change cover photo
    @IBAction func loadCoverButtonTapped(_ sender: UIButton) {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    //Opens photo gallery
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //Here save picture, and change it as well - Save onto DB here
        dismiss(animated: true, completion: nil)
    }
    //Cancels changes
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //This is when no image is picked and user pressed cancel
        dismiss(animated: true, completion: nil)
    }
    
    //Segment Controller case statements
    
    @IBAction func switchbetween(_ sender: UISegmentedControl){
        switch  tablecontrol.selectedSegmentIndex{
        case 0:
            //Connect to Database here
            //bookmarkreview = false
            bookmarkreview = true
            print("Bookmark")
            Table.reloadData()
        case 1:
            //Connect to Database here
            bookmarkreview = false
            print("review")
            Table.reloadData()
        default:
            //Connect to Database here
            bookmarkreview = true
            Table.reloadData()
            print("Bookmark")
        }
    }
    

    
}
extension UIImageView{
    func makeRounded() {

        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}


