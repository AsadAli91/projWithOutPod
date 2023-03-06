//
//  TakePhoto.swift
//  SoloinsightAssignment
//
//  Created by Asad on 27/02/2023.
//

import Foundation
import UIKit

class TakePhoto: BaseViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func chooseImageFromLibrary() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    func takePhotoWithCamera() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .camera
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
}
