//
//  DbRef.swift
//  socialNewsIO
//
//  Created by LogicAppSourceIO on 16/08/2017.
//  Copyright © 2017 Logicappsource. All rights reserved.
//

import Foundation
import Firebase

class DBRef {
    
    var ref: DatabaseReference!
    ref = Database.database().reference()

}



