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
import Firebase

class ProfileController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var bookmarkreview = true
    var bookmarked: [String] = [] {
        didSet {
            Table.reloadData()
        }
    }
    var review: [String:String] = [:] {
        didSet {
            Table.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let label = UILabel(frame: CGRect(x:0, y:0, width:200, height:50))
        if bookmarkreview {
            print(bookmarked)
            for _ in bookmarked {
                // bookmark cell restaurant name labels
                cell.textLabel?.text = bookmarked[indexPath.row]
            }
        } else {
            label.text = "Not Hello"
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if bookmarkreview {
            return bookmarked.count
            
        } else {
            return 3
        }
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
    
    // true for image; false for cover
    var imageSelected: Bool = true;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Make profile picture rounded
        Photo.makeRounded()
        //Use Person's entered name as default Text
        self.nameField.placeholder = "First Last"
        //Update Label based on the user profile here
        
        //Table view
        Table.dataSource = (self as UITableViewDataSource)
        Table.delegate = (self as UITableViewDelegate)
       
        profile()
        
        setProfileAndBackgroundPics()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ProfileController.imageTapped(gesture:)))
        Photo.isUserInteractionEnabled = true
        Photo.addGestureRecognizer(tapGesture)
        
        let tapGestureCover = UITapGestureRecognizer(target: self, action: #selector(ProfileController.coverTapped(gesture:)))
        CoverPhoto.isUserInteractionEnabled = true
        CoverPhoto.addGestureRecognizer(tapGestureCover)
    }
    
    func setProfileAndBackgroundPics() {
        // MARK:- GET IMAGE FROM UID PATH
        
        let storageRefProfile = Storage.storage().reference().child("profile.jpg")
        storageRefProfile.getData(maxSize: 20*1024*1024, completion: { (imagedata, error) in
            if let error = error {
                print("Got an error getting the profile image: \(error)")
                return
            }
            self.Photo.image = UIImage(data: imagedata!)
        })
        
        let storageRefBackground = Storage.storage().reference().child("background.jpg")
        storageRefBackground.getData(maxSize: 20*1024*1024, completion: { (imageCoverdata, error) in
            if let error = error {
                print("Got an error getting the profile image: \(error)")
                return
            }
            self.CoverPhoto.image = UIImage(data: imageCoverdata!)
        })
    }
    
    @objc func imageTapped(gesture: UIGestureRecognizer) {
        // if the tapped view is a UIImageView then set it to imageview
        if (gesture.view as? UIImageView) != nil {
            print("Image Tapped")
            imageSelected = true
            let alertController = UIAlertController(title: nil, message: "Do you want to change your Profile Picture?", preferredStyle: .actionSheet)
            
            alertController.addAction(UIAlertAction(title: "Change Profile Picture", style: .destructive, handler: { (_) in
                self.imgCntlr()
            }))
                
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
    
    func imgCntlr() {
        imageSelected = true
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func cvrCntlr() {
        imageSelected = false
        let coverPicker = UIImagePickerController()
        coverPicker.delegate = self
        coverPicker.allowsEditing = true
        coverPicker.sourceType = .photoLibrary
        present(coverPicker, animated: true, completion: nil)
    }
    
    @objc func coverTapped(gesture: UIGestureRecognizer) {
        // if the tapped view is a UIImageView then set it to imageview
        if (gesture.view as? UIImageView) != nil {
            print("Cover Tapped")
            imageSelected = false
            let alertController = UIAlertController(title: nil, message: "Do you want to change your Backgound Picture?", preferredStyle: .actionSheet)
            
            alertController.addAction(UIAlertAction(title: "Change Background Picture", style: .destructive, handler: { (_) in
                self.cvrCntlr()
            }))
                
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
    
    //Opens photo gallery
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("image controller")
        //Here save picture, and change it as well - Save onto DB here
        if (imageSelected) {
            Photo.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            
            //MARK:- CHANGE TO UID PATH
            
            let storageRef = Storage.storage().reference().child("profile.jpg")
            if let uploadData = self.Photo.image!.jpegData(compressionQuality: 0.0) {
                storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                    if error != nil {
                        print("error")
                        return
                    } else {
                        print("profile pic storage save success")
                    }
               }
            }
        } else {
            CoverPhoto.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            let storageRefBack = Storage.storage().reference().child("background.jpg")
            if let uploadDataBack = self.CoverPhoto.image!.jpegData(compressionQuality: 0.0) {
                storageRefBack.putData(uploadDataBack, metadata: nil) { (metadata, error) in
                    if error != nil {
                        print("error")
                        return
                    } else {
                        print("background pic storage save success")
                    }
               }
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    //Cancels changes
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //This is when no image is picked and user pressed cancel
        dismiss(animated: true, completion: nil)
    }
    
    func profile() -> Void {
        Profile.getProfile(profileID:"Still need to decide on user identifier", completion: {profile in
            self.bookmarked = profile.bookmarked
            self.review = profile.review
            print(profile.bookmarked)
        })
    }
    
    //Segment Controller case statements
    @IBAction func switchbetween(_ sender: UISegmentedControl) {
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


extension UIImageView {
    
    func makeRounded() {
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
    
}
