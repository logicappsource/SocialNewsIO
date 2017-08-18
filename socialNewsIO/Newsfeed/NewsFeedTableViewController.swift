//
//  NewsFeedTableViewController.swift
//  socialNewsIO
//
//  Created by LogicAppSourceIO on 17/08/2017.
//  Copyright © 2017 Logicappsource. All rights reserved.
//

import UIKit
import Firebase

class NewsFeedTableViewController: UITableViewController {

    struct Storyboard {
            static let showWelcome = "ShowWelcomeViewController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Check if the user logged in or not
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                // user is logged in
            } else {
                self.performSegue(withIdentifier: Storyboard.showWelcome, sender: nil)
            }
        }
    
    }
    
    
    
}
