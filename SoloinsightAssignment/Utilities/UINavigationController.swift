//
//  UINavigationController.swift
//  SoloinsightAssignment
//
//  Created by Asad on 27/02/2023.
//

import Foundation
import UIKit

extension UINavigationController {
    func transparentNavigationBar() {
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
    }
    
    func setTintColor(_ color: UIColor) {
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: color]
        self.navigationBar.tintColor = color
    }
    
    func backgroundColor(_ color: UIColor) {
        navigationBar.setBackgroundImage(nil, for: .default)
        navigationBar.barTintColor = color
        navigationBar.shadowImage = UIImage()
    }
}

extension UINavigationController {
    
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        if let vc = viewControllers.filter({$0.isKind(of: ofClass)}).last {
            popToViewController(vc, animated: animated)
        }
    }
    
    func popViewControllers(viewsToPop: Int, animated: Bool = true) {
        if viewControllers.count > viewsToPop {
            let vc = viewControllers[viewControllers.count - viewsToPop - 1]
            popToViewController(vc, animated: animated)
        }
    }
}


extension UINavigationController {
    func removeAllControllersAndAddNewController(withController controller: UIViewController) {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = scene.windows.first {
            UIView.transition(with: window,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: {
                                self.viewControllers.removeAll()
                                self.pushViewController(controller, animated: false)
                              },
                              completion: nil)
        }
    }
}
