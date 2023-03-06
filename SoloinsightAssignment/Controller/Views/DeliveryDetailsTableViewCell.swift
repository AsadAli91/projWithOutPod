//
//  DeliveryDetailsTableViewCell.swift
//  SoloinsightAssignment
//
//  Created by Asad on 05/03/2023.
//

import UIKit

class DeliveryDetailsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var selectdriverView: UIView!
    @IBOutlet weak var selectTenantView: UIView!
    @IBOutlet weak var vehicleNoView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        self.selectdriverView.addBorder(width: 1, color: UIColor.gray, radius: 10)
        self.selectTenantView.addBorder(width: 1, color: UIColor.gray, radius: 10)
        self.vehicleNoView.addBorder(width: 1, color: UIColor.gray, radius: 10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
