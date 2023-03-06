//
//  Utilities.swift
//  SoloinsightAssignment
//
//  Created by Asad on 27/02/2023.
//

import Foundation
import UIKit

class Utilities{
    static let shared = Utilities()
    
    func getViewController(identifier: String, storyboardType: StoryboardType) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardType.rawValue, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
}
