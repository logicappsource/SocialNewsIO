//
//  ImagePickerHelper.swift
//  socialNewsIO
//
//  Created by LogicAppSourceIO on 17/08/2017.
//  Copyright © 2017 Logicappsource. All rights reserved.
//

//import Foundation
import UIKit
import MobileCoreServices


typealias ImagePickerHelperCompletion = ((UIImage?) -> Void)!

class ImagePickerHelper: NSObject
{

    // Actionsheet, ImagePickerController ==> viewController
    weak var viewController: UIViewController!
    var completion: ImagePickerHelperCompletion
//    var imagePickerController: UIImagePickerController?
    
    
    
     init(viewController:  UIViewController, completion: ImagePickerHelperCompletion) {
            self.viewController = viewController
            self.completion = completion
            super.init()
            self.showPhotoSourceSelection()
    }
    
    
    func showPhotoSourceSelection()
    {
        let actionSheet = UIAlertController(title: "Pick New Photo", message: "Would you like to open photos library or camera", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { action in
                self.showImagePicker(sourceType: .camera)
            })
        let photosLibraryAction = UIAlertAction(title: "Photos Library" , style: .default, handler: { action in
                self.showImagePicker(sourceType: .photoLibrary)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                actionSheet.addAction(cameraAction)
                actionSheet.addAction(photosLibraryAction)
                actionSheet.addAction(cancelAction)
            
                self.viewController.present(actionSheet, animated: true, completion: nil)
        }
    
    func showImagePicker(sourceType: UIImagePickerControllerSourceType)
        {
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = true
            imagePicker.sourceType = sourceType
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.delegate = self
            
            viewController.present(imagePicker, animated: true, completion: nil)
        }
    
    }

    
extension ImagePickerHelper: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        viewController.dismiss(animated: true, completion: nil)
    }
    
    
    
    
}
