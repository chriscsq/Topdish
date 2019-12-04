//
//  ProfileController.swift
//  Topdish
//
//  Created by Simran Bhattarai on 2019-11-26.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import Foundation
import UIKit

class ProfileController: UIViewController {
   //Define variables
    @IBOutlet weak var CoverPhoto: UIImageView!
    @IBOutlet weak var Photo: UIImageView!
    @IBOutlet weak var nameField:UITextField!
    
    
    
    
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
        
        
        
        
    }
    
    @IBAction func loadImageButtonTapped(_ sender: UIButton) {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //Here save picture, and change it as well
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //No change
        dismiss(animated: true, completion: nil)
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


