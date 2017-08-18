//
//  ProfileVC.swift
//  socialNewsIO
//
//  Created by LogicAppSourceIO on 18/08/2017.
//  Copyright © 2017 Logicappsource. All rights reserved.
//

import UIKit
import Firebase

class ProfileVC: UITableViewController {

    
    @IBAction func logOutDidTap(_ sender: Any) {
        try! Auth.auth().signOut()
        dismiss(animated: true, completion: nil)
        self.tabBarController?.selectedIndex = 0 
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    

}
