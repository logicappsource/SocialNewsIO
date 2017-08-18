//
//  WelcomeVC.swift
//  socialNewsIO
//
//  Created by LogicAppSourceIO on 17/08/2017.
//  Copyright © 2017 Logicappsource. All rights reserved.
//

import UIKit
import Firebase
class WelcomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                self.dismiss(animated: false, completion: nil)
            } else {
                
            }
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    
    
}
