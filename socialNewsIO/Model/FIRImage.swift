//
//  FIRImage.swift
//  socialNewsIO
//
//  Created by LogicAppSourceIO on 16/08/2017.
//  Copyright © 2017 Logicappsource. All rights reserved.
//

import Foundation
import Firebase

class FIRImage
{
    var image: UIImage
    var downloadURl: URL?
    var downloadLink: String!
    var ref: StorageReference!
    
    init(image: UIImage) {
        self.image = image
    }
    
}


extension FIRImage
{
    func saveProfileImage(_ userUID: String, _ completion: @escaping (Error?) -> Void)
    {
            let resizedImage = image.resized()
            let imageData = UIImageJPEGRepresentation(resizedImage, 0.9)
        
            ref = DTStorageReference.profileImages.reference().child(userUID)     // /profileimage/ path

            downloadLink = ref.description
        
            ref.putData(imageData!, metadata: nil) { (metaData, error) in
                completion(error)
        }
    }
    
    func save(_ uid: String, completion: @escaping (Error?) -> Void)
    {
        // path // images/uid
        let resizedImage = image.resized()
        let imageData = UIImageJPEGRepresentation(resizedImage, 0.9)
        
        ref = DTStorageReference.images.reference().child(uid) // Profileimage/path
        
        downloadLink = ref.description
        
        ref.putData(imageData!, metadata: nil) { (metaData, error) in
                completion(error)
        }
    
    }
    
}


extension FIRImage
{
    class func downloadProfileImage(_ uid: String, completion: @escaping (UIImage? , Error?) -> Void)
    {
        DTStorageReference.profileImages.reference().child(uid).getData(maxSize: 1 * 1024 * 1024) { (imageData, error) in // 1 MB data
            if error == nil && imageData != nil {
                let image = UIImage(data: imageData!)
                completion(image, error)
            } else {
                completion(nil ,error)
            }
        }
    }
    
    class func downloadImage(uid: String, completion: @escaping(UIImage?, Error? ) -> Void ) {
        DTStorageReference.images.reference().child(uid).getData(maxSize: 1 * 1024 * 1024) { (imageData, error) in // 1 MB data
            if error == nil && imageData != nil {
                let image = UIImage(data: imageData!)
                completion(image, error)
            } else {
                completion(nil ,error)
            }
        }
    }
}


private extension UIImage
{
    func resized() -> UIImage {
        let height: CGFloat = 800.00
        let ratio = self.size.width / self.size.height
        let width = height * ratio
        
        let newSize = CGSize(width: width, height: height)
        let newRectangle = CGRect(x: 0 , y:0 , width: width, height: height)
        
        UIGraphicsBeginImageContext(newSize)
        self.draw(in: newRectangle)
        
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage!
    }
}
