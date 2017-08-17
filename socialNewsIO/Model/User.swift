//
//  User.swift
//  socialNewsIO
//
//  Created by LogicAppSourceIO on 14/08/2017.
//  Copyright © 2017 Logicappsource. All rights reserved.
// 1. bug is the reference to FIREBASE

import Foundation
import FirebaseDatabase
import UIKit

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

    // MARK: - Initializers

    init(uid: String, username: String, fullName: String, bio: String, website: String, follows: [User], followedBy: [User], profileImage: UIImage?) {
        self.uid = uid
        self.username = username
        self.fullName = fullName
        self.bio = bio
        self.website = website
        self.follows = follows
        self.followedBy = followedBy
        self.profileImage = profileImage
    }
    
    
    init(dictionary: [String : Any])
    {
        uid = dictionary["uid"] as! String
        username = dictionary["username"] as! String
        fullName = dictionary["fullname"] as! String
        bio = dictionary["bio"] as! String
        website = dictionary["website"] as! String
        
        //Follows
        self.follows = []
        if let followsDict = dictionary["follows"] as? [String: Any] {
            for (_, userDict) in followsDict {
                if let userDict = userDict as? [String: Any] {
                    self.follows.append(User(dictionary: userDict))
                }
            }
        }
    
        //FollowedBy
        self.followedBy = []
        if let followedByDict = dictionary["followedBy"] as? [String: Any] {
            for (_ ,userDict) in followedByDict {
                if let userDict = userDict as? [String: Any]{//Check if cast did succed
                    self.followedBy.append(User(dictionary: userDict))
                }
            }
        }
    }


    
    func save(completion: @escaping (Error?) -> Void )  {
        
        //1. Reference pointing to Dict
        let ref = DTDatabaseReference.users(uid: uid).reference()
        ref.setValue(toDictionary()) // Bug in console
        
        //2. - save follows
        for user in follows { // Set Val
            ref.child("follows/\(user.uid)").setValue(user.toDictionary()) // Set val bug occur
        }
        
        //3. - save followed by "followedby"
        for user in followedBy {
            ref.child("followedBy/\(user.uid)").setValue(user.toDictionary()) // Set val bug occur
        }
        
        //4. - save the profile image
        if let profileImage = self.profileImage {
            let firImage = FIRImage(image:profileImage)
            firImage.saveProfileImage(self.uid, { (error) in
                completion(error)
            })
        }
    }

    func toDictionary() -> [String: Any] { //Return to dict
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

