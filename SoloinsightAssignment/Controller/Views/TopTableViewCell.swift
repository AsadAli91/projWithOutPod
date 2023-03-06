//
//  TopTableViewCell.swift
//  SoloinsightAssignment
//
//  Created by Asad on 05/03/2023.
//

import UIKit

class TopTableViewCell: UITableViewCell {

    
    @IBOutlet weak var plateNumberView: UIView!
    @IBOutlet weak var scanLP: UIView!
    
    @IBOutlet weak var carrierCompanyView: UIView!
    @IBOutlet weak var vehicleNo: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewBoarder()
    }
    
    func viewBoarder(){
        
        plateNumberView.addBorder(width: 1, color: UIColor.gray, radius: 10)
        scanLP.addBorder(width: 1, color: UIColor.blue, radius: 10)
        carrierCompanyView.addBorder(width: 1, color: UIColor.gray, radius: 10)
        vehicleNo.addBorder(width: 1, color: UIColor.blue, radius: 10)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
