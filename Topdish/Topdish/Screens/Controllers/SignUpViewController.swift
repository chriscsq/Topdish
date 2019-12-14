//
//  SignUpViewController.swift
//  Topdish
//
//  Created by Karndeep Dhami on 2019-11-26.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        assignbackground()
        setUpElements()
    }
    
    func setUpElements() {
        
        // Hide the error label
        errorLabel.alpha = 0
        
        // Style the elements
        Utilities.styleTextField(nameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleTextField(repeatPasswordTextField)
        Utilities.styleFilledButton(signUpButton)
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
    
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if (nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            repeatPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "") {
            
            return "Please fill in all fields."
        }
        
        // Check if the password is secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if (Utilities.isPasswordValid(cleanedPassword) == false) {
            // Password isn't secure enough
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        
        if (passwordTextField.text != repeatPasswordTextField.text) {
            return "Both passwords do not match."
        }
        
        return nil
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        // Validate the fields
        let error = validateFields()
        
        if (error != nil) {
            
            // There's something wrong with the fields, show error message
            showError(error!)
        }
        else {
            
            // Create cleaned versions of the data
            let name = nameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                // Check for errors
                if (err != nil) {
                    
                    // There was an error creating the user
                    self.showError("Error creating user")
                }
                else {
                    
                    // User was created successfully, now store the first name and last name
//                    let db = Firestore.firestore()
                    let db = Database.database().reference()
                    
//                    db.collection("users").addDocument(data: ["name":name, "uid": result!.user.uid ]) { (error) in
//                    db.collection("users").document(result!.user.uid).setData(["name":name]) { (error) in
                    db.child("profile").child(result!.user.uid).setValue(["name":name, "email":email]) { (error:Error?, ref:DatabaseReference) in
                        if error != nil {
                            // Show error message
                            self.showError("Error saving user data")
                        }
                    }
                    
//                    let photo = UIImage(named: "profileImage")!
//                    let background = UIImage(named: "banff")!
//                    let photoData = photo.jpegData(compressionQuality: 0.5)
//                    let backgroundData = background.jpegData(compressionQuality: 0.5)
//
//                    let storageRef = Storage.storage().reference()
//
//                    let profileRef = storageRef.child("profile").child(result!.user.uid).child("profile.jpg")
//                    profileRef.putData(photoData!, metadata: nil) { (metadata, error) in
//                        if error != nil {
//                            print("error uploading to storage")
//                            return
//                        }
//                        print("profile save success")
//                    }
//
//                    let backgroundRef = storageRef.child("profile").child(result!.user.uid).child("background.jpg")
//                    backgroundRef.putData(backgroundData!, metadata: nil) { (metadata, error) in
//                        if error != nil {
//                            print("error uploading to storage")
//                            return
//                        }
//                        print("background save success")
//                    }
                                        
                    // Transition to the home screen
                    self.transitionToHome()
                }
            }
        }
    }
    
    func showError(_ message:String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome() {
                
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let viewController = storyBoard.instantiateViewController(identifier: Constants.Storyboard.tabBarCon) as! UITabBarController
        viewController.selectedIndex = 2
        self.view.window?.rootViewController = viewController
        self.view.window?.makeKeyAndVisible()
    }
}
