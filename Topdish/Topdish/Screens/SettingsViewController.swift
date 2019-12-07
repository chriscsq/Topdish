//
//  SettingsViewController.swift
//  Topdish
//
//  Created by Karndeep Dhami on 2019-11-26.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FBSDKCoreKit
import FBSDKLoginKit

class SettingsViewController: UIViewController {
    
    var ref: DatabaseReference! = Database.database().reference()
    var guest: Bool!

    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        checkIfUserLoggedIn()

        // Do any additional setup after loading the view.
    }
    
    func checkIfUserLoggedIn() {
        if (Auth.auth().currentUser?.uid == nil) {
            // disable logged in user features
            guest = true
            self.testLabel.text = "Welcome Guest \nCreate an Account"
            self.signOutButton.setTitle("exit", for: .normal)
        } else {
            guest = false
            // testing getting user name and displaying it
            // not working with facebook at initial signup/login
            let uID = Auth.auth().currentUser?.uid
            print(uID!)
            ref.child("profile").child(uID!).observeSingleEvent(of: .value, with: {(snapshot) in
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    self.testLabel.text = dictionary["name"] as? String
                }
                
            }, withCancel: nil)
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
            let viewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.startViewController) as? StartViewController
            
            self.view.window?.rootViewController = viewController
            self.view.window?.makeKeyAndVisible()
        } catch let error {
            print("Failed to sign out with error..", error)
        }
    }
}
