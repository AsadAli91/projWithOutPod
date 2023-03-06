//
//  LoginViewController.swift
//  SoloinsightAssignment
//
//  Created by Asad on 27/02/2023.
//

import UIKit

class LoginViewController: BaseViewController {

    
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        viewModel.bindLoginViewModel(self)
        self.viewDesign()
        self.buttonDesign()
    }
    
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    

    
    @IBAction func loginButtonPressed(_ sender: Any){
        let isInputValid = viewModel.isInputValied(emailTxtField.text ?? "", passwordTxtField.text ?? "")
        if isInputValid { viewModel.loginUser() }
    }
}

// MARK: - Design Views

extension LoginViewController{
    
    func viewDesign(){
        emailView.addBorder(width: 1, color: UIColor.gray, radius: 8)
        passwordView.addBorder(width: 1, color: UIColor.gray, radius: 8)
    }
    
    func buttonDesign(){
        loginBtn.setCornerRadius(10)
        signUpBtn.setCornerRadius(10)
    }
    
}


// MARK: - Protocol

extension LoginViewController: LoginProtocol{
    
    func successLogin(success: String) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func failureLogin(errorString: String) {
        showToast(message: errorString)
    }
}
