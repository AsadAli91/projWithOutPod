//
//  DriverDetailsTableViewCell.swift
//  SoloinsightAssignment
//
//  Created by Asad on 05/03/2023.
//

import UIKit

class DriverDetailsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var driverNameView: UIView!
    @IBOutlet weak var takePhotoView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.driverNameView.addBorder(width: 1, color: UIColor.gray, radius: 10)
        self.takePhotoView.addBorder(width: 1, color: UIColor.gray, radius: 10)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    
    }
    
}
