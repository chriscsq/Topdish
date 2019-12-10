//
//  ProfileController.swift
//  Topdish
//
//  Created by Simran Bhattarai on 2019-11-26.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//
import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FBSDKCoreKit
import FBSDKLoginKit

class ProfileController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
   //Define variables
    @IBOutlet weak var CoverPhoto: UIImageView!
    @IBOutlet weak var Photo: UIImageView!
    @IBOutlet weak var nameField:UITextField!
    @IBOutlet weak var tablecontrol:UISegmentedControl!
    //These need to be connected to the DB
    @IBOutlet weak var numberofReview: UILabel!
    @IBOutlet weak var numberoflikeddishes:UILabel!
    @IBOutlet weak var Table: UITableView!
    @IBOutlet weak var signOutButton: UIButton!
    
    @IBOutlet weak var registerLoginButton: UIButton!
    // true for image; false for cover
    var imageSelected: Bool = true;

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
    
    var ref: DatabaseReference! = Database.database().reference()
    var guest: Bool!
    
    var uID: String?
    
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
        
//        setProfileAndBackgroundPics()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ProfileController.imageTapped(gesture:)))
        Photo.isUserInteractionEnabled = true
        Photo.addGestureRecognizer(tapGesture)
        
        let tapGestureCover = UITapGestureRecognizer(target: self, action: #selector(ProfileController.coverTapped(gesture:)))
        CoverPhoto.isUserInteractionEnabled = true
        CoverPhoto.addGestureRecognizer(tapGestureCover)
        
        checkIfUserLoggedIn()
    }
    
    func checkIfUserLoggedIn() {
        if (Auth.auth().currentUser?.uid == nil) {
            print("no user signed in")
            // disable logged in user features
            guest = true
            signOutButton.isHidden = true
            signOutButton.isEnabled = false
            registerLoginButton.isHidden = false
            registerLoginButton.isEnabled = true
            hideEverything()
        } else {
            print("user signed in")
            guest = false
            signOutButton.isHidden = false
            signOutButton.isEnabled = true
            registerLoginButton.isHidden = true
            registerLoginButton.isEnabled = false
            showEverything()
            
            // testing getting user name and displaying it
            // not working with facebook at initial signup/login but does at subsequent visits
//            let uID = Auth.auth().currentUser?.uid
            uID = Auth.auth().currentUser?.uid
            print(uID!)
            
            //MARK:-Move profile call to here
//            profile()
            setProfileAndBackgroundPics()
            
            ref.child("profile").child(uID!).observeSingleEvent(of: .value, with: {(snapshot) in
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    self.nameField.text = dictionary["name"] as? String
                }
                
            }, withCancel: nil)
        }
    }
    
    func setProfileAndBackgroundPics() {
//        let storageRefProfile = Storage.storage().reference().child("profile.jpg")
        // get from correct path of uid
        let storageRefProfile = Storage.storage().reference().child("profile").child(Auth.auth().currentUser!.uid).child("profile.jpg")

        storageRefProfile.getData(maxSize: 20*1024*1024, completion: { (imagedata, error) in
            if let error = error {
                print("Got an error getting the profile image: \(error)")
                return
            }
            self.Photo.image = UIImage(data: imagedata!)
        })
        
//        let storageRefBackground = Storage.storage().reference().child("background.jpg")
        // get from correct path of uid
        let storageRefBackground = Storage.storage().reference().child("profile").child(Auth.auth().currentUser!.uid).child("background.jpg")
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
                        
//            let storageRef = Storage.storage().reference().child("profile.jpg")
            let storageRef = Storage.storage().reference().child("profile").child(Auth.auth().currentUser!.uid).child("profile.jpg")
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
//            let storageRefBack = Storage.storage().reference().child("background.jpg")
            let storageRefBack = Storage.storage().reference().child("profile").child(Auth.auth().currentUser!.uid).child("background.jpg")
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellId")
//        let cell = tableView.dequeueReusableCell(withIdentifier: "yourCellIdentifier", for: indexPath) as! YourCell

        let restaurantList = [String](review.keys)
        
        if bookmarkreview {
            print(bookmarked)
            for _ in bookmarked {
                // bookmark cell restaurant name labels
                cell.textLabel?.text = bookmarked[indexPath.row]
            }
        } else {
            print(review)
            for _ in review {
                // key of review dictionary = names of restaurant and dish
                cell.textLabel?.numberOfLines = 0
                cell.textLabel?.lineBreakMode = .byWordWrapping
                cell.textLabel?.text = restaurantList[indexPath.row]
                // value of review dictionary = actual review of dish
                cell.detailTextLabel?.numberOfLines = 0
                cell.detailTextLabel?.lineBreakMode = .byWordWrapping
                cell.detailTextLabel?.text = review[restaurantList[indexPath.row]]
            }
        }
        
        
        return cell
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if bookmarkreview {
            return bookmarked.count
            
        } else {
            return review.count
        }
    }
    
    func profile() -> Void {
        // MARK:-include uID for profileID
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
    
    
    @IBAction func signOutTapped(_ sender: Any) {
        handleSignOut()
    }
    
    @objc func handleSignOut() {
        let alertController = UIAlertController(title: nil, message: "Are you sure you want to leave?", preferredStyle: .actionSheet)
        if (!guest) {
            alertController.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { (_) in
                self.signOut()
            }))
        } else {
            alertController.addAction(UIAlertAction(title: "Exit", style: .destructive, handler: { (_) in
                self.signOut()
            }))
        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func signOut() {
        do {
            try Auth.auth().signOut()
//            let viewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.startViewController) as? StartViewController
            let storyBoard: UIStoryboard = UIStoryboard(name: "Profile", bundle:nil)
            let viewController = storyBoard.instantiateViewController(identifier: Constants.Storyboard.profileController) as? ProfileController
                        
            self.view.window?.rootViewController = viewController
            self.view.window?.makeKeyAndVisible()
        } catch let error {
            print("Failed to sign out with error..", error)
        }
    }
    
    func hideEverything() {
        CoverPhoto.isHidden = true
        Photo.isHidden = true
        nameField.isHidden = true
        numberofReview.isHidden = true
        numberoflikeddishes.isHidden = true
        tablecontrol.isHidden = true
        Table.isHidden = true
        
    }
    
    func showEverything() {
        CoverPhoto.isHidden = false
        Photo.isHidden = false
        nameField.isHidden = false
        numberofReview.isHidden = false
        numberoflikeddishes.isHidden = false
        tablecontrol.isHidden = false
        Table.isHidden = false
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
