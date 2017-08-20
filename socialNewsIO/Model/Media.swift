//
//  Media.swift
//  socialNewsIO
//
//  Created by LogicAppSourceIO on 18/08/2017.
//  Copyright © 2017 Logicappsource. All rights reserved.
//  Could be possible due to comment class should be in DBREference switch statement.

import UIKit
import Firebase

class Media {
    var uid: String
    var type: String // "image" or "video"
    var caption: String
    var createdTime: Double
    var createdBy: User
    var likes: [User]
    var comments: [Comment]
    var mediaImage: UIImage!
    
    init (type: String, caption: String, createdBy: User, image: UIImage) {
            self.type = type
            self.caption = caption
            self.createdBy = createdBy
            self.mediaImage = image
        
            createdTime = Date().timeIntervalSince1970  // number of seconds -> now
            comments = []
            likes = []
            uid = DTDatabaseReference.media.reference().childByAutoId().key
    }
    
    
    func save(completion: @escaping (Error?) -> Void ) {
        let ref = DTDatabaseReference.media.reference().child(uid)
        ref.setValue(toDictionary())

        // Save Likes
        for like in likes {
            ref.child("likes/\(like.uid)").setValue(like.toDictionary())
        }
        // Save Comments
        for comment in comments {
            ref.child("comments/\(comment.uid)").setValue(comment.toDictionary())
        }
        
        // Upload Images to storage Databse
        let firImage = FIRImage(image: mediaImage)
        firImage.save(self.uid) { (error) in
            completion(error)
        }
        
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "uid": uid,
            "type": type,
            "caption": caption,
            "createdTime": createdTime,
            "createdBy": createdBy.toDictionary()
        ]
    }
    
}



class Comment {
    var mediaUID: String
    var uid: String
    var createdTime: Double
    var from: User
    var caption: String
    var ref: DTDatabaseReference // Could be DT
    
    init(mediaUID: String, from: User, caption: String) {
        self.mediaUID = mediaUID
        self.from = from
        self.caption = caption
        self.createdTime = Date().timeIntervalSince1970
        
        let ref = DTDatabaseReference.media.reference().child("\(mediaUID)/comments").childByAutoId()
        uid = ref.key
    }
    
    init(dictionary: [String : Any] ) {
        uid = dictionary["uid"] as! String
        createdTime = dictionary["createdTime"] as! Double
        caption = dictionary["caption"] as! String
        
        let fromDictionary = dictionary["from"] as! [String: Any]
        from = User(dictionary: fromDictionary)
        
        mediaUID = dictionary["mediaUID"] as! String
        let ref = DTDatabaseReference.media.reference().child("\(mediaUID)/comments/\(uid)")
    }
    
    func save() {
//       ref.reference().setValue(toDictionary())  // Resolving a bug
        let ref = DTDatabaseReference.media.reference().child("\(mediaUID)/comments/\(uid)")
        ref.setValue(toDictionary())
    }
    
    func toDictionary() -> [String: Any]
    {
        return [
        "mediaUID": mediaUID,
        "uid": uid,
        "createdTime": createdTime,
        "from": from.toDictionary(),
        "caption": caption
        ]
    }
}

extension Media {
    
    func downloadMediaImage(completion: @escaping (UIImage?, Error?) -> Void) {
        FIRImage.downloadImage(uid: uid) { (image, error) in
                completion(image,error)
        }
    }
}


/*
 /media {
     mediaUID1
             createdBy
             createdByTime
             comments
                 commentUID1   - value
                     commentUID2  - value
             likes: likeUID,
 
 }
 
 */
