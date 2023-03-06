//
//  UIView+Extension.swift
//  SoloinsightAssignment
//
//  Created by Asad on 26/02/2023.
//

import Foundation
import UIKit

extension UIView {
    func addBorder(width: CGFloat, color: UIColor, radius: CGFloat) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}
