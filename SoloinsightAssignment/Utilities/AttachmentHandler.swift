//
//  AttachmentHandler.swift
//  TennisFights
//
//  Created by Hamza on 30/9/22.
//  Copyright © 2022 TechSwivel. All rights reserved.
//

import Foundation
//
//  AttachmentHandler.swift
//  Udeo Globe
//
//  Created by Nasar Iqbal on 4/13/20.
//  Copyright © 2020 Yasir Iqbal. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices
import AVFoundation
import Photos
import OpalImagePicker

/*
 AttachmentHandler.shared.showAttachmentActionSheet(vc: self)
 AttachmentHandler.shared.imagePickedBlock = { (image) in
 /* get your image here */
 }
 */

protocol AttachmentHandlerDelegate {
    func compressionFailed()
    func onVideoLimitExcede()
}


class AttachmentHandler: NSObject{
    static let shared = AttachmentHandler()
    fileprivate var currentVC: UIViewController?
    
    //MARK: - Internal Properties
    var imagePickedBlock: (([UIImage]) -> Void)?
    var videoPickedBlock: ((NSURL) -> Void)?
    var filePickedBlock: ((URL) -> Void)?
    var imageSelectionLimit = 0
    var delegate : AttachmentHandlerDelegate?
    enum AttachmentType: String{
        case camera, video, photoLibrary, VideoCamera
    }
    
    enum VideoCamera {
        case videoCamera
    }
    
    enum AttachmentFileType: String{
        case image, video,file
    }
    
    
    //MARK: - Constants
    struct Constants {
        static let actionFileTypeHeading = "Add a File"
        static let actionFileTypeDescription = "Choose a filetype to add..."
        static let camera = "Camera"
        static let phoneLibrary = "Phone Library"
        static let video = "Video Library"
        static let file = "File"
        static let videoCamera = "Video Camera"
        
        static let alertForPhotoLibraryMessage = "App does not have access to your photos. To enable access, tap settings and turn on Photo Library Access."
        
        static let alertForCameraAccessMessage = "App does not have access to your camera. To enable access, tap settings and turn on Camera."
        
        static let alertForVideoLibraryMessage = "App does not have access to your video. To enable access, tap settings and turn on Video Library Access."
        
        
        static let settingsBtnTitle = "Settings"
        static let cancelBtnTitle = "Cancel"
        
    }
    
    
    
    //MARK: - showAttachmentActionSheet
    // This function is used to show the attachment sheet for image, video, photo and file.
    func showAttachmentActionSheet(vc: UIViewController,type:AttachmentFileType) {
       
        currentVC = vc
        let actionSheet = UIAlertController(title: Constants.actionFileTypeHeading, message: Constants.actionFileTypeDescription, preferredStyle: .actionSheet)
        switch type {
        case .image:
         

            actionSheet.addAction(UIAlertAction(title: Constants.camera, style: .default, handler: { (action) -> Void in
                self.authorisationStatus(attachmentTypeEnum: .camera, vc: self.currentVC!)
            }))
            
            actionSheet.addAction(UIAlertAction(title: Constants.phoneLibrary, style: .default, handler: { (action) -> Void in
                self.authorisationStatus(attachmentTypeEnum: .photoLibrary, vc: self.currentVC!)
            }))
        case .video:
          
            actionSheet.addAction(UIAlertAction(title: Constants.videoCamera, style: .default, handler: { (action) -> Void in
                self.authorisationStatus(attachmentTypeEnum: .VideoCamera, vc: self.currentVC!)
            }))
            
            actionSheet.addAction(UIAlertAction(title: Constants.video, style: .default, handler: { (action) -> Void in
                self.authorisationStatus(attachmentTypeEnum: .video, vc: self.currentVC!)
                
            }))
            
        case .file:
           
            actionSheet.addAction(UIAlertAction(title: Constants.file, style: .default, handler: { (action) -> Void in
                self.documentPicker()
            }))
        }
        
        actionSheet.addAction(UIAlertAction(title: Constants.cancelBtnTitle, style: .cancel, handler: nil))
        if let popoverController = actionSheet.popoverPresentationController {
            popoverController.sourceView = self.currentVC?.view
            popoverController.sourceRect = CGRect(x: (self.currentVC?.view.bounds.midX) ?? 0, y: (self.currentVC?.view.bounds.midY) ?? 0, width: 0, height: 0)
            popoverController.permittedArrowDirections = UIPopoverArrowDirection()
        }
        vc.present(actionSheet, animated: true, completion: nil)
    }
    
    //MARK: - Authorisation Status
    // This is used to check the authorisation status whether user gives access to import the image, photo library, video.
    // if the user gives access, then we can import the data safely
    // if not show them alert to access from settings.
    func authorisationStatus(attachmentTypeEnum: AttachmentType, vc: UIViewController){
        currentVC = vc
        
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            if attachmentTypeEnum == AttachmentType.camera{
                openCamera()
            }
            if attachmentTypeEnum == AttachmentType.VideoCamera {
                openVideoCamera()
            }
            if attachmentTypeEnum == AttachmentType.photoLibrary{
                photoLibrary()
            }
            if attachmentTypeEnum == AttachmentType.video{
                videoLibrary()
            }
        case .denied:
            self.addAlertForSettings(attachmentTypeEnum)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({ (status) in
                if status == PHAuthorizationStatus.authorized{
                    // photo library access given
                    if attachmentTypeEnum == AttachmentType.camera{
                        self.openCamera()
                    }
                    if attachmentTypeEnum == AttachmentType.VideoCamera{
                        self.openVideoCamera()
                    }
                    if attachmentTypeEnum == AttachmentType.photoLibrary{
                        self.photoLibrary()
                    }
                    if attachmentTypeEnum == AttachmentType.video{
                        self.videoLibrary()
                    }
                }else{
                    self.addAlertForSettings(attachmentTypeEnum)
                }
            })
        case .restricted:
            self.addAlertForSettings(attachmentTypeEnum)
        default:
            break
        }
    }
    
    
    //MARK: - CAMERA PICKER
    //This function is used to open camera from the iphone and
    func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            DispatchQueue.main.async {
                let myPickerController = UIImagePickerController()
                myPickerController.delegate = self
                myPickerController.sourceType = .camera
                self.currentVC?.present(myPickerController, animated: true, completion: nil)
            }
            
        }else
        {
            DispatchQueue.main.async {
                Utils.showToast(view:self.currentVC!.view,message: "Camera source is not availbale ")
            }
        }
    }
    
    
    //MARK: - VideoCamera Picker
    func openVideoCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            DispatchQueue.main.async {
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .camera
            myPickerController.mediaTypes = [kUTTypeMovie as String, kUTTypeVideo as String]
            self.currentVC?.present(myPickerController, animated: true, completion: nil)
            }
        }
        else {
            DispatchQueue.main.async {
                Utils.showToast(view: (self.currentVC?.view)!, message: "Video Camera Source is not Availble")
            }
            
        }
    }
    
    
    //MARK: - PHOTO PICKER
    func photoLibrary(){
        

        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            DispatchQueue.main.async {
            let myPickerController = OpalImagePickerController()
                myPickerController.imagePickerDelegate = self
                myPickerController.allowedMediaTypes = Set([PHAssetMediaType.image])
                myPickerController.maximumSelectionsAllowed = self.imageSelectionLimit
            self.currentVC?.present(myPickerController, animated: true, completion: nil)
        }
                
            }
    }
    
    //MARK: - VIDEO PICKER
    func videoLibrary(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            DispatchQueue.main.async {
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .photoLibrary
            myPickerController.mediaTypes = [kUTTypeMovie as String, kUTTypeVideo as String]
            self.currentVC?.present(myPickerController, animated: true, completion: nil)
            }
        }
    }
    
    //MARK: - FILE PICKER
    func documentPicker(){
        let importMenu = UIDocumentMenuViewController(documentTypes: [String(kUTTypePDF)], in: .import)
        importMenu.delegate = self
        importMenu.modalPresentationStyle = .formSheet
        currentVC?.present(importMenu, animated: true, completion: nil)
    }
    
    //MARK: - SETTINGS ALERT
    func addAlertForSettings(_ attachmentTypeEnum: AttachmentType){
        var alertTitle: String = ""
        if attachmentTypeEnum == AttachmentType.camera{
            alertTitle = Constants.alertForCameraAccessMessage
        }
        if attachmentTypeEnum == AttachmentType.photoLibrary{
            alertTitle = Constants.alertForPhotoLibraryMessage
        }
        if attachmentTypeEnum == AttachmentType.video{
            alertTitle = Constants.alertForVideoLibraryMessage
        }
        if attachmentTypeEnum == AttachmentType.VideoCamera {
            alertTitle = Constants.alertForCameraAccessMessage
        }
        
        DispatchQueue.main.async {
        let cameraUnavailableAlertController = UIAlertController (title: alertTitle , message: nil, preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: Constants.settingsBtnTitle, style: .destructive) { (_) -> Void in
            let settingsUrl = NSURL(string:UIApplication.openSettingsURLString)
            if let url = settingsUrl {
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            }
        }
        let cancelAction = UIAlertAction(title: Constants.cancelBtnTitle, style: .default, handler: nil)
        cameraUnavailableAlertController .addAction(cancelAction)
        cameraUnavailableAlertController .addAction(settingsAction)
        self.currentVC?.present(cameraUnavailableAlertController , animated: true, completion: nil)
        }
    }
}

//MARK: - IMAGE PICKER DELEGATE
// This is responsible for image picker interface to access image, video and then responsibel for canceling the picker
extension AttachmentHandler: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        currentVC?.dismiss(animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.imagePickedBlock?([image])
        }
        
        if let videoUrl = info[UIImagePickerController.InfoKey.mediaURL] as? NSURL{
          
            //trying compression of video
            let data = NSData(contentsOf: videoUrl as URL)!
           
            compressWithSessionStatusFunc(videoUrl)
        }
        currentVC?.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Video Compressing technique
    fileprivate func compressWithSessionStatusFunc(_ videoUrl: NSURL) {
    
        let compressedURL = NSURL.fileURL(withPath: NSTemporaryDirectory() + NSUUID().uuidString + ".mp4")
            self.compressVideo(inputURL: videoUrl as URL, outputURL: compressedURL) { (exportSession) in
            guard let session = exportSession else {
                return
            }
            
            switch session.status {
            case .unknown:
               
                break
            case .waiting:
               
                break
            case .exporting:
              
                break
            case .completed:
                
                guard let compressedData = NSData(contentsOf: compressedURL) else {
                    return
                }
               
                DispatchQueue.main.async {
                    self.videoPickedBlock?(compressedURL as NSURL)
                }
              
            
                
                    
    
            case .failed:
              
                ///if Compression failed then User will be informed
                
                DispatchQueue.main.async {
                    self.delegate?.compressionFailed()
                }
                
                break
            case .cancelled:
                break
            
            }
        }
    
    }
    
    private func getMediaDuration(url: URL!) -> Float64{
        let asset : AVURLAsset = AVURLAsset(url: url) as AVURLAsset
        let duration : CMTime = asset.duration
        return CMTimeGetSeconds(duration)
    }
    
    /// Now compression is happening with medium quality, we can change when ever it is needed
    func compressVideo(inputURL: URL, outputURL: URL, handler:@escaping (_ exportSession: AVAssetExportSession?)-> Void) {
        let urlAsset = AVURLAsset(url: inputURL, options: nil)
        //AVAssetExportPresetPassthrough
        guard let exportSession = AVAssetExportSession(asset: urlAsset, presetName: AVAssetExportPresetPassthrough) else {
            handler(nil)
            return
        }
        exportSession.outputURL = outputURL
        exportSession.outputFileType = AVFileType.mp4
        exportSession.shouldOptimizeForNetworkUse = true
        exportSession.exportAsynchronously { () -> Void in
            handler(exportSession)
        }
    }
    
    func convertPHAssetsIntoImages(phAssest: [PHAsset]) -> [UIImage] {
      var photoArray = [UIImage]()
        if phAssest.count != 0 {
            for i in 0..<phAssest.count {
                let manager = PHImageManager()
                let option = PHImageRequestOptions()
                var image = UIImage()
                option.isSynchronous = true
                manager.requestImage(for: phAssest[i], targetSize: CGSize(width: 700, height: 700), contentMode: .aspectFit, options: option) { (results, info) in
                    if let result = results {
                        image = result
                    }
                }
                photoArray.append(image)
            }
        }
        return photoArray
        
    }
}

//MARK: - FILE IMPORT DELEGATE
extension AttachmentHandler: UIDocumentMenuDelegate, UIDocumentPickerDelegate{
    func documentMenu(_ documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        currentVC?.present(documentPicker, animated: true, completion: nil)
    }
    
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
       
        self.filePickedBlock?(url)
    }
    
    //    Method to handle cancel action.
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        currentVC?.dismiss(animated: true, completion: nil)
    }
    
}


extension AttachmentHandler : OpalImagePickerControllerDelegate {
    func imagePicker(_ picker: OpalImagePickerController, didFinishPickingAssets assets: [PHAsset]) {

        DispatchQueue.main.async { [weak self] in
                    self?.imagePickedBlock?(self?.convertPHAssetsIntoImages(phAssest: assets) ?? [UIImage]())
                }
        currentVC?.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerDidCancel(_ picker: OpalImagePickerController) {

        currentVC?.dismiss(animated: true, completion: nil)
    }
}
