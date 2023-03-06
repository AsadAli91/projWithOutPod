//
//  DeliveryDetailsTwoTableViewCell.swift
//  SoloinsightAssignment
//
//  Created by Asad on 05/03/2023.
//

import UIKit

class DeliveryDetailsTwoTableViewCell: UITableViewCell {

    @IBOutlet weak var packageTypeView: UIView!
    @IBOutlet weak var howManyView: UIView!
    
    @IBOutlet weak var itemPlusBtn: UIButton!
    @IBOutlet weak var itemMinusBtn: UIButton!
    
    @IBOutlet weak var inputTextFied: UITextField!

    var itemPlusTaped:(()->Void)?
    var itemMinusTaped:(()->Void)?
    var textFieldValueChangged:((_ value:String)->Void)?
    

    override func awakeFromNib() {
        super.awakeFromNib()
       
        self.selectionStyle = .none
        self.packageTypeView.addBorder(width: 1, color: UIColor.gray, radius: 10)
        self.howManyView.addBorder(width: 1, color: UIColor.gray, radius: 10)
        
    }
  
    
    @IBAction private func textFieldValueChanegd(_ sender: UITextField) {
        textFieldValueChangged?(sender.text ?? "")
    }
    
    
    @IBAction private func minusBtnTapped(_ sender:UIButton){
        itemMinusTaped?()
    }
    
    @IBAction private func plusBtnTapped(_ sender:UIButton){
        itemPlusTaped?()
    }
    
    
    func setValue(value:String){
        inputTextFied.text = value
    }
}

