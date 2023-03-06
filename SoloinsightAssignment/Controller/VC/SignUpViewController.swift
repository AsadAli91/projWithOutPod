//
//  ViewController.swift
//  SoloinsightAssignment
//
//  Created by Asad on 26/02/2023.
//

import UIKit
import RealmSwift

class SignUpViewController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var firstNameView: UIView!
    @IBOutlet weak var LastNameView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var confirmPasswordView: UIView!
    
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var imageview: UIImageView!
    
    
    @IBOutlet weak var firstNameTxtField: UITextField!
    @IBOutlet weak var LastNameTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var confirmPasswordTxtField: UITextField!
    
    @IBOutlet weak var takePhotoBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    
    let takeImage = TakePhoto()
    var getImageData = Data()
    
    private let viewModel = SignUpViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.bindViewModel(self)
        self.viewDesign()
        self.buttonDesign()
        
    }
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popToViewController(ofClass: LoginViewController.self)
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        
        viewModel.signUPModelRealm.userFirstName = firstNameTxtField.text ?? ""
        viewModel.signUPModelRealm.userLastName = LastNameTxtField.text ?? ""
        viewModel.signUPModelRealm.userEmail = emailTxtField.text ?? ""
        viewModel.signUPModelRealm.userPassword = passwordTxtField.text ?? ""
        viewModel.signUPModelRealm.userConfirmPassword = confirmPasswordTxtField.text ?? ""
        viewModel.signUPModelRealm.userImage = self.getImageData
  
        let isInputValid = viewModel.isInputValied()
        if isInputValid { viewModel.saveData() }
    }
    
    @IBAction func cameraButtonPressed(_ sender: Any) {
        
        AttachmentHandler.shared.imageSelectionLimit = 1
        AttachmentHandler.shared.showAttachmentActionSheet(vc: self,type: AttachmentHandler.AttachmentFileType.image)
        AttachmentHandler.shared.imagePickedBlock = {[weak self] (image) in
        
            if let imageData = image[0].jpegData(compressionQuality: 1.0) {
                self?.getImageData = imageData
            }
            
            self?.imageview.image = image.first
            self?.imageview.contentMode = .scaleAspectFill
            
            // self?.imageView.circleImageView()
            // self?.imageview.image = image
            // let image = UIImage(data: imageData)
        }
    }
}



// MARK: - view + Button design

extension SignUpViewController {
    
    func viewDesign(){
  
        firstNameView.addBorder(width: 1, color: UIColor.gray, radius: 8)
        LastNameView.addBorder(width: 1, color: UIColor.gray, radius: 8)
        emailView.addBorder(width: 1, color: UIColor.gray, radius: 8)
        passwordView.addBorder(width: 1, color: UIColor.gray, radius: 8)
        confirmPasswordView.addBorder(width: 1, color: UIColor.gray, radius: 8)
        
        imageView.addBorder(width: 1, color: UIColor.gray, radius: 0)
        imageView.makeRound()
    }
    
    func buttonDesign(){
        takePhotoBtn.setCornerRadius(10)
        signUpBtn.setCornerRadius(10)
    }
}


extension SignUpViewController{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let chosenImage = info[.originalImage] as? UIImage {
            print(chosenImage)
            imageview.image = chosenImage
        }
        dismiss(animated: true, completion: nil)
    }
}


extension SignUpViewController:SignUpProtocol{
    
    func success(message: String) {
        self.showToast(message: message)
        self.navigationController?.popToViewController(ofClass: LoginViewController.self)
    }
    
    func failure(errorString: String) {
        self.showToast(message: errorString)
    }
}





/*
 
 image get here...
 
 let realm = try! Realm()
 let person = realm.object(ofType: SignUPModelRealm.self, forPrimaryKey: 1)
 if let image = UIImage(data: person!.userImage){
     self.imageview.image = image
 }
 
 */
