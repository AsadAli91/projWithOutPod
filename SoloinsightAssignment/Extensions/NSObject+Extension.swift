//
//  NSObject+Extension.swift
//  SoloinsightAssignment
//
//  Created by Asad on 05/03/2023.
//

import Foundation

extension NSObject {
    class var className: String {
        return String(describing: self)
    }
}
