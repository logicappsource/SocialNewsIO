//
//  User.swift
//  socialNewsIO
//
//  Created by LogicAppSourceIO on 14/08/2017.
//  Copyright © 2017 Logicappsource. All rights reserved.
// 1. bug is the reference to FIREBASE

import Foundation
import Firebase

class User
{
    let uid: String
    var username: String
    var fullName: String
    var bio: String
    var website: String
    var profileImage: UIImage?
    var follows: [User]
    var followedBy: [User]



    init(uid:String, username: String, fullName: String, bio: String, website: String, profileImage: UIImage?, follows: [User], followedBy: [User]) {
        self.uid = uid
        self.username = username
        self.fullName = fullName
        self.bio = bio
        self.website = website
        self.profileImage = profileImage
    }

    

    
    func save()  {
        
        //1. Reference pointing to Dict
        let ref = DatabaseReference.users(uid: uid).reference()
        ref.setValue(toDictionary)
        
        // 2 - save follows
        for user in follows { // Set Val
            ref.child("follows/\(user.uid)").setValue(toDictionary())
        }
        
        //3 - save followed by "followedby"
        for user in followedBy {
            ref.child("followedBy/\(user.uid)").setValue(user.toDictionary())
        }
        
        //4 - save the profile image
        
        
    }

    func toDictionary() -> [String: Any] {
            return [
                "uid":uid,
                "username": username,
                "fullName": fullName,
                "bio": bio,
                "website": website,
                "profileImage": profileImage
        ]
    }
    
    
}

