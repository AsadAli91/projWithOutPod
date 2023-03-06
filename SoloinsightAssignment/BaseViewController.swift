//
//  BaseViewController.swift
//  SoloinsightAssignment
//
//  Created by Asad on 26/02/2023.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    //MARK: - Toast Methods
    func showToast(message : String, yPosition: CGFloat = 100, xPosition: CGFloat = 20) {
        let window = UIApplication.shared.keyWindow!
        let toastLabel = UILabel(frame: CGRect(x: xPosition, y: self.view.frame.size.height-yPosition, width: self.view.frame.width - 40, height: 40))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        toastLabel.textColor = UIColor.white
        toastLabel.font = UIFont.systemFont(ofSize: 12)
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.numberOfLines = 2
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
       // toastLabel.font = UIFont(name: APP_MANAGER.fontRubikMedium, size: 15)
        window.addSubview(toastLabel)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            toastLabel.removeFromSuperview()
        }
    }
}
