//
//  StartViewController.swift
//  Topdish
//
//  Created by Karndeep Dhami on 2019-11-26.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class StartViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
        authenticateUserAndConfigure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        GIDSignIn.sharedInstance()?.uiDelegate = self
        GIDSignIn.sharedInstance()?.delegate = self
    }
    
    func setUpElements() {
        Utilities.styleFilledButton(signInButton)
        Utilities.styleHollowButton(signUpButton)
    }

    func authenticateUserAndConfigure() {
        if(Auth.auth().currentUser == nil) {
            print("no user")
        } else {
            print("user signed in: ", String(Auth.auth().currentUser!.uid))
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(identifier: Constants.Storyboard.settingsViewController)
            navigationController?.pushViewController(controller, animated: false)
            
        }
    }


    @IBAction func googleButtonTapped(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        print("sign in with google")
        
        if error != nil {
            print("Failed to sign in with google")
            return
        }
        
        guard let authentication = user.authentication else {
            return
        }
        let credentials = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credentials) { (result, error) in
            if error != nil {
                print("failed to sign in and retreive data with error: ", error!)
            } else {
                let db = Database.database().reference()
                
                guard let uid = result?.user.uid else { return }
                guard let name = result?.user.displayName else { return }
                guard let email = result?.user.email else {return}
                
                db.child("profile").child(uid).updateChildValues(["name":name, "email": email]) { (error:Error?, ref:DatabaseReference) in
                    if error != nil {
                        // Show error message
                        print("Error saving user data")
                    } else {
                        self.transitionToHome()
                    }
                }
                
            }
        }
    }
    
    func transitionToHome() {
        let settingsViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.settingsViewController) as? SettingsViewController
        view.window?.rootViewController = settingsViewController
        view.window?.makeKeyAndVisible()
    }
}
