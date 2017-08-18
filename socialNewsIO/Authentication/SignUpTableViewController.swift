//
//  SignUpTableViewController.swift
//  socialNewsIO
//
//  Created by LogicAppSourceIO on 17/08/2017.
//  Copyright © 2017 Logicappsource. All rights reserved.
//

import UIKit
import Firebase

class SignUpTableViewController: UITableViewController {

    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var fullNameTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var usernameTxtField: UITextField!
    
    var imagePickerHelper: ImagePickerHelper!
    var profileImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2.0
        profileImageView.layer.masksToBounds = true
        emailTxtField.delegate = self
        fullNameTxtField.delegate = self
        passwordTxtField.delegate = self
        usernameTxtField.delegate = self
        
        title = "Create New Account"
    }
    
    @IBAction func createNewAccountDidTap() {
        //Create new account
        //Save user data, take a photo
        //login data
        print("Test button is clicked ")
        if emailTxtField.text != ""
            && (passwordTxtField.text?.characters.count)! > 6
            && (fullNameTxtField.text?.characters.count)! > 6
            && (usernameTxtField.text?.characters.count)! > 6
            && profileImage != nil  {
            print(passwordTxtField.text,  fullNameTxtField.text , usernameTxtField.text)
            let email = self.emailTxtField.text!
            let fullName = self.fullNameTxtField.text!
            let profileImage = self.profileImageView.image!
            let password = self.passwordTxtField.text!
            let username = self.usernameTxtField.text!
            
            Auth.auth().createUser(withEmail: email, password: password , completion: { (firUser, error) in
                if error != nil {
                        //Report the error
                } else if let firUser = firUser {
                    print("Sucessfuly created the new user Auth FIR ")
                    
                    let newUser = User(uid: firUser.uid, username: username, fullName: fullName, bio: "", website: "", follows: [], followedBy: [], profileImage: self.profileImage)
                    newUser.save(completion: { ( error) in
                        if error != nil {
                            // report could not sign up new user
                            self.alertUser(title: error!.localizedDescription, message: "err", buttonTitle: "OK")
                        } else {
                            //success Alert -  new user  signed up
                            self.alertUser(title: "Success", message: "YES", buttonTitle: "OK")
                            Auth.auth().signIn(withEmail: email, password: password, completion: { (firUser, error) in
                                if let error = error {
                                        //Report error
                                    
                                } else {
                                    self.dismiss(animated: true, completion: nil)
                                }
                            })
                        }
                    })
    
                    //error lozalized descrp alert view
                    self.alertUser(title: "Succesfully Created", message: "User", buttonTitle: "OK")
                } else {
                    self.alertUser(title: error!.localizedDescription, message: "Wrong", buttonTitle: "OK")
                }
            })
        }
    }
    
    @IBAction func backDidTap(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func changeProfilePhotoDidTap(_ sender: Any)
    {
        imagePickerHelper = ImagePickerHelper(viewController: self, completion: { (image) in
                self.profileImageView.image =  image
                self.profileImage = image
        })
    }
    
}

extension SignUpTableViewController {
    func alertUser(title: String, message: String, buttonTitle: String)
    {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: title, style: .default , handler:  { (alert) in
        })
        alertView.addAction(action)
        self.present(alertView, animated: true, completion: nil)
    }
}


extension SignUpTableViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailTxtField {
            fullNameTxtField.becomeFirstResponder()
        } else if textField == fullNameTxtField {
            fullNameTxtField.becomeFirstResponder()
        } else if textField == usernameTxtField {
            usernameTxtField.resignFirstResponder()
            createNewAccountDidTap()
        } else if textField == passwordTxtField{
            passwordTxtField.resignFirstResponder()
        }
        return true
    }
}


