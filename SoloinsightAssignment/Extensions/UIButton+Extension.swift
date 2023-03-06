//
//  UIButton+Extension.swift
//  SoloinsightAssignment
//
//  Created by Asad on 27/02/2023.
//

import Foundation
import UIKit

extension UIButton {
    func setCornerRadius(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}


extension UIView {
    func makeRound() {
        self.layer.cornerRadius = self.frame.size.height / 2
        self.clipsToBounds = true
    }
}
