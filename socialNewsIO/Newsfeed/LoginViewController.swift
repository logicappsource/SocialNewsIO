//
//  LoginViewController.swift
//  socialNewsIO
//
//  Created by LogicAppSourceIO on 17/08/2017.
//  Copyright © 2017 Logicappsource. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {


    //Alert user if nothing is typed or if creds is wrong
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login to MomentsIO"
        
        usernameTxtField.becomeFirstResponder()
        usernameTxtField.delegate = self
        passwordTxtField.delegate = self
    }
    
    
    @IBOutlet weak var usernameTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    
    @IBAction func loginBtnTap(_ sender: Any) {
   
        if usernameTxtField.text != "" &&  (usernameTxtField.text?.characters.count)! > 5 && (passwordTxtField.text?.characters.count)! > 5 {
            
             let username = usernameTxtField.text!
             let password = passwordTxtField.text!
            
            print("userame =  \(username)  and password =  \(password)")
            
            Auth.auth().signIn(withEmail: username, password: password, completion: { (user, error) in
                //User succesfully logged in
                //Do Error handling  - if let error = erroor {}
                print(username, password )
                self.alert(title: "Successfully signed in", message: "Welcome to Moment", buttonTitle: "OK")
                self.dismiss(animated: true, completion: nil)
            })
            
        } else {
            print("User Creds Failed to be stored ")
        }
        
    }
    
}
    

extension LoginViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTxtField {
            passwordTxtField.becomeFirstResponder()
        } else if textField == passwordTxtField {
            passwordTxtField.resignFirstResponder()
            loginBtnTap(self)
        }
        return true
    }

}


extension LoginViewController: UIAlertViewDelegate {
    
    func alert(title: String, message: String, buttonTitle: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Close", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    
    
}
