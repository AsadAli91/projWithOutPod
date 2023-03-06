//
//  LoginViewModel.swift
//  SoloinsightAssignment
//
//  Created by Asad on 03/03/2023.
//

import Foundation


protocol LoginProtocol{
    func successLogin(success: String)
    func failureLogin(errorString: String)
}

class LoginViewModel{
    
    private var delegate: LoginProtocol?
    
    
    func bindLoginViewModel(_ delegate: LoginProtocol){
        self.delegate = delegate
    }
    
    
    func isInputValied(_ email: String, _ pass: String)->Bool{
        
        var errorString = ""
        
        let realmEmail = NSPredicate(format: "userEmail == %@", email)
        let getEmail = realmDB().fetchData(SignUPModelRealm.self, realmEmail)
        
        
        let realmPass = NSPredicate(format: "userPassword == %@", pass)
        let getPass = realmDB().fetchData(SignUPModelRealm.self, realmPass)

        if email.isEmpty {
            errorString = "Please enter email"
        }else if pass.isEmpty {
            errorString = "Please enter password"
        }else if !email.isValidEmail(){
            errorString = "email is invalid"
        }else if getEmail.isEmpty{
            errorString = "Incorect Email"
        }else if getPass.isEmpty{
            errorString = "Incorect Password"
        }
   
        
        if errorString != ""{
            self.delegate?.failureLogin(errorString: errorString)
            return false
        }
        
        return true
    }
    
    func loginUser(){
        self.delegate?.successLogin(success: "success")
    }
}
