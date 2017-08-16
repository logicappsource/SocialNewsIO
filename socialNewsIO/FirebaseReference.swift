//
//  FirebaseReference.swift
//  socialNewsIO
//
//  Created by LogicAppSourceIO on 16/08/2017.
//  Copyright © 2017 Logicappsource. All rights reserved.
//

import Foundation
import Firebase




enum DatabaseReference {

    
  case root
  case users(uid: String)
  case media  // Post
  case chats // Chats
  case messages
    

    // MARK : -  Public
    
    func reference() -> DatabaseReference {
        return ref.child(path)
    }
    
    private var  ref: DatabaseReference {
        return Database.database().reference()
    }
  
    
    private var path: String {
        
        switch self {
        case .root:
            return ""
        case .users(let uid):
            return "users/\(uid)"
        case .media:
            return "media"
        case .chats:
            return "chats"
        case .messages:
            return "messages"
        default:
            return ""
            
        }
        
    }
    
    
    
    
}
