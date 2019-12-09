//
//  DishReviewController.swift
//  Topdish
//
//  Created by Simran Bhattarai on 2019-12-08.
//  Copyright © 2019 Topdish Inc. All rights reserved.
//

import Foundation
import UIKit

struct dishrev {
    var id:Int
    var title:String
    var rate: String
}

protocol receiveData {
    func sendDishname(dishname:String)
}
class DishReviewController:UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

        //variables
        var delegate:receiveData?
        var nameofDish:String = ""
        var rate:Int = 0
        var exp:String = ""
    
        //Modal View Buttons
        @IBOutlet weak var dishName: UITextField!
        @IBOutlet weak var dishRate: UITextField!
        @IBOutlet weak var dishexp: UITextView!
        @IBOutlet weak var dishupload: UIButton!
        @IBOutlet weak var dishpic: UIImageView!
        @IBOutlet weak var adddish: UIButton!
    
    
    override func viewDidLoad() {
         super.viewDidLoad()//Input Variables
        //nameofDish = dishName.text
        //print(nameofDish ?? "lol")
        //rate = dishRate.text
        //exp = dishexp.text
        
        
    }
    
    
    @IBAction func nameentered(_ sender: UITextField) {
        dishName.resignFirstResponder()
        //RECEIVE DISH NAME HERE
        nameofDish = dishName.text! //<<DISH NAME
        if delegate != nil{
            self.delegate?.sendDishname(dishname: nameofDish)
        }else{
           print("The delegate is nil")
         }
    
        return
        
    }
    
    @IBAction func receivedishrate(_ sender: Any) {
        rate = Int(dishRate.text!)!
        return
    }
    func loadAndParse(){
        //print(nameofDish)
        
    }
    
    @IBAction func uploaddish(_ sender: Any) {
        var myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        self.present(myPickerController, animated:true, completion: nil)
        
        
    }
    
    //Cancels changes
       func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           //This is when no image is picked and user pressed cancel
           dismiss(animated: true, completion: nil)
       }
    
    //Opens photo gallery
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //Here save picture, and change it as well - Save onto DB here
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                      dishpic.contentMode = .scaleAspectFit
                      dishpic.image = pickedImage
                  }
        dismiss(animated: true, completion: nil)
        
        self.dishupload.isEnabled = false
        //disabled new upload lol
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if let vc2 = segue.destination as? DishReviewController{
            vc2.delegate = (self as! receiveData)
           }
       }
    
    @IBAction func donefunc(_ sender: UIButton) {
        print(nameofDish)
        
        self.dismiss(animated: true) {NotificationCenter.default.post(name: NSNotification.Name(rawValue: "modalIsDimissed"), object: nil) }
        //print("cancel")
    }
    
    
}
