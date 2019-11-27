//
//  SettingsViewController.swift
//  Topdish
//
//  Created by Karndeep Dhami on 2019-11-26.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    @IBOutlet weak var signOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signOutTapped(_ sender: Any) {
        handleSignOut()
    }
    
    @objc func handleSignOut() {
        let alertController = UIAlertController(title: nil, message: "Are you sure you want to sign out?", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { (_) in
            self.signOut()
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func signOut() {
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
