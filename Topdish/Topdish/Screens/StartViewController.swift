//
//  StartViewController.swift
//  Topdish
//
//  Created by Karndeep Dhami on 2019-11-26.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit

class StartViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var guestButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        assignbackground()
        setUpElements()
        authenticateUserAndConfigure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // make nav bar translucent
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        GIDSignIn.sharedInstance()?.uiDelegate = self
        GIDSignIn.sharedInstance()?.delegate = self
    }

    
    func assignbackground(){
        let background = UIImage(named: "background")

        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
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

    @IBAction func guestButtonTapped(_ sender: Any) {
        transitionToHome()
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
    
    @IBAction func facebookButtonTapped(_ sender: Any) {
        print(1234)
        
        LoginManager().logIn(permissions: ["email"], from: self) { (result, err) in
            if err != nil {
                print("Custom FB Login failed:", err as Any)
                return
            } else if (result!.isCancelled) {
                print("The user cancelled loggin in")
            } else {
                self.saveUserData()
            }
        }
    }
    
    func saveUserData() {
        let accessToken = AccessToken.current
        guard let accessTokenString = accessToken?.tokenString else { return }
        
        let credentials = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
        Auth.auth().signIn(with: credentials, completion: { (result, error) in
            if error != nil {
                print("Something went wrong with our FB user: ", error ?? "")
                return
            } else {
                print("user signed in with facebook")
            }
            
            let userId = result?.user.uid
            let db = Database.database().reference()
//            let usersRef = ref.child("users").child(userId!)
            
            GraphRequest(graphPath: "/me", parameters: ["fields": "name, email"]).start { (connection, result, err) in
                
                if err != nil {
                    print("Failed to start graph request:", err ?? "")
                    return
                }
                print("graph results")
                print(result ?? "")
                
                let values: [String:AnyObject] = result as! [String : AnyObject]
                
                db.child("profile").child(userId!).updateChildValues(values, withCompletionBlock: { (err, ref) in
                     // if there's an error in saving to our firebase database
                     if err != nil {
                        print(err as Any)
                         return
                     }
                     // no error, so it means we've saved the user into our firebase database successfully
                     print("Save the user successfully into Firebase database")
                 })
                
            }
        })
        self.transitionToHome()
    }
    
    func transitionToHome() {
        let settingsViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.settingsViewController) as? SettingsViewController
        view.window?.rootViewController = settingsViewController
        view.window?.makeKeyAndVisible()
    }
}
