//
//  Utils.swift
//  Base iOS Project
//
//  Created by Mac on 13/01/2021.
//  Copyright © 2021 TechSwivel. All rights reserved.
//

import Foundation
import UIKit

class Utils {
  
    static public func showToast(view:UIView,message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: view.frame.size.width/2 - 150, y: view.frame.size.height-100, width: 300, height: 45))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
       // toastLabel.font = FontConstants.getSegeoUIRegular(size: 15)
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.numberOfLines = 10
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        view.addSubview(toastLabel)
        UIView.animate(withDuration: 5.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    
    static public func showToast(view:UIView,message : String,complete onComplete: @escaping () -> Void) {
        
        let toastLabel = UILabel(frame: CGRect(x: view.frame.size.width/2 - 150, y: view.frame.size.height-100, width: 300, height: 45))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
       // toastLabel.font = FontConstants.getSegeoUIRegular(size: 15)
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.numberOfLines = 10
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        view.addSubview(toastLabel)
        UIView.animate(withDuration: 5.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            onComplete()
            toastLabel.removeFromSuperview()
        })
    }
    
    static public func showAlert(vc : UIViewController,title:String,message:String,titleYesButton:String,onYesPress yes: @escaping () -> Void){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: titleYesButton, style: .default) { (action) in
            yes()
        }

        alert.addAction(yesAction)

        vc.present(alert, animated: true)
    }
    
    static public func showAlert(vc:UIViewController,message:String){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        vc.present(alert, animated: true)
    }
    
}

