//
//  LoginViewModel.swift
//  SoloinsightAssignment
//
//  Created by Asad on 27/02/2023.
//

import Foundation
import RealmSwift
import Realm
import SQLite3

protocol SignUpProtocol{
    func success (message: String)
    func failure (errorString: String)
}

class SignUpViewModel{
    
    private var deleget:SignUpProtocol?
    
    var signUPModelRealm = SignUPModelRealm()
    
    func bindViewModel(_ deleget:SignUpProtocol){
        self.deleget = deleget
    }
    

    func isInputValied()->Bool{
        var errorString = ""

        
        if signUPModelRealm.userFirstName.isEmpty {
            errorString = "Please enter first name"
        }else if signUPModelRealm.userLastName.isEmpty{
            errorString = "Please enter last name"
        }else if signUPModelRealm.userEmail.isEmpty{
            errorString = "Please enter email"
        }else if signUPModelRealm.userPassword.isEmpty{
            errorString = "Please enter password"
        }else if signUPModelRealm.userConfirmPassword.isEmpty{
            errorString = "Please enter confirm password"
        }else if !signUPModelRealm.userEmail.isValidEmail(){
            errorString = "email is invalid"
        }
        
        signUPModelRealm.id += signUPModelRealm.id + 1
        
        if errorString != ""{
            self.deleget?.failure(errorString: errorString)
            return false
        }
        
        return true
    }
    
    func saveData(){
        // let exestingUser = realmDB().fetchData(SignUPModelRealm.self)
        
        let realm = try! Realm()
        let person = realm.objects(SignUPModelRealm.self).filter("userEmail == %@", signUPModelRealm.userEmail).first
        if person != nil{
            self.deleget?.failure(errorString: "User is alreday exist")
        }else{
            let isSaved = realmDB().write(signUPModelRealm)
            print("isSaved ",isSaved)
            self.deleget?.success(message: "User SignUp successfully")
        }
    }
    
//    func fetchData(_ getImage: UIImage){
//        let predicate = NSPredicate(format: "userEmail == %@", signUPModelRealm.userEmail)
//        print(predicate)
//        let exestingUser = realmDB().fetchData(SignUPModelRealm.self)
//
//    }
}
