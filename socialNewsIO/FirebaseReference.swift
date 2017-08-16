//
//  FirebaseReference.swift
//  socialNewsIO
//
//  Created by LogicAppSourceIO on 16/08/2017.
//  Copyright © 2017 Logicappsource. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

enum DTDatabaseReference
{

    case root
    case users(uid: String)
    case media   //Posts
    case chats
    case messages
    
    // MARK - Public
    
    func reference() -> DatabaseReference {
        return rootRef.child(path)
    }
    
    private var rootRef: DatabaseReference {
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


enum DTStorageReference {
    
    case root
    case images         //for Post
    case profileImages // For User
    
    func reference() -> StorageReference {
        return baseRef.child(path)
    }
    
    private var baseRef: StorageReference {
        return Storage.storage().reference()
    }
    
    private var path: String{
        switch self {
        case .root:
            return ""
        case .images:
            return "images"
        case .profileImages:
            return "profileImages"
        
        }
    }
    
  
    
}
