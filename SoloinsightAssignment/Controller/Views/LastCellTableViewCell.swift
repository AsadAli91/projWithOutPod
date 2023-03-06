//
//  LastCellTableViewCell.swift
//  SoloinsightAssignment
//
//  Created by Asad on 05/03/2023.
//

import UIKit

class LastCellTableViewCell: UITableViewCell {

    @IBOutlet weak var manitestView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.manitestView.addBorder(width: 1, color: UIColor.gray, radius: 10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
