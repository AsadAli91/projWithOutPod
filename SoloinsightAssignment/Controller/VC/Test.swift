//
//  Test.swift
//  SoloinsightAssignment
//
//  Created by Asad on 05/03/2023.
//

import Foundation
//
//  HomeViewController.swift
//  SoloinsightAssignment
//
//  Created by Asad on 04/03/2023.
//








/*
import UIKit

class HomeViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    
    var fixedItemInSectionTwo = 2
    var userInputs:[String] = [""]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: String(describing: TopTableViewCell.self), bundle: Bundle.main), forCellReuseIdentifier: TopTableViewCell.className)
        
        self.tableView.register(UINib(nibName: String(describing: DriverDetailsTableViewCell.self), bundle: Bundle.main), forCellReuseIdentifier: DriverDetailsTableViewCell.className)
        
        self.tableView.register(UINib(nibName: String(describing: DeliveryDetailsTableViewCell.self), bundle: Bundle.main), forCellReuseIdentifier: DeliveryDetailsTableViewCell.className)
        
        self.tableView.register(UINib(nibName: String(describing: DeliveryDetailsTwoTableViewCell.self), bundle: Bundle.main), forCellReuseIdentifier: DeliveryDetailsTwoTableViewCell.className)
        
        
        self.tableView.register(UINib(nibName: String(describing: LastCellTableViewCell.self), bundle: Bundle.main), forCellReuseIdentifier: LastCellTableViewCell.className)
        
        
        
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popToViewController(ofClass: LoginViewController.self)
    }
    
    
    
    func textFieldValueChangged(value:String, index:Int){
        let arrayIndex = index - 1
        userInputs[arrayIndex] = value
    }
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else if section == 1{
            return 1
        }else if section == 2{
            return fixedItemInSectionTwo + userInputs.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "TopTableViewCell") as! TopTableViewCell
            return cell
            
        }else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DriverDetailsTableViewCell") as! DriverDetailsTableViewCell
            return cell
            
        }else if indexPath.section == 2{
            if indexPath.item == 0 { // first
                let cell = tableView.dequeueReusableCell(withIdentifier: "DeliveryDetailsTableViewCell") as! DeliveryDetailsTableViewCell
                return cell
                
            }else if indexPath.item == (fixedItemInSectionTwo + userInputs.count) - 1 { // last cell
                let cell = tableView.dequeueReusableCell(withIdentifier: "LastCellTableViewCell") as! LastCellTableViewCell
                return cell
                
                
            }else if indexPath.item == (fixedItemInSectionTwo + userInputs.count) - 2 { // second last
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "DeliveryDetailsTwoTableViewCell") as! DeliveryDetailsTwoTableViewCell
                cell.itemPlusTaped = {
                    self.userInputs.append("")
                    self.tableView.reloadSections(IndexSet(integer: 2), with: .none)
                }
                cell.textFieldValueChangged = { value in
                    self.textFieldValueChangged(value: value, index: indexPath.item)
                }
                
                cell.setValue(value: userInputs[indexPath.item - 1])
                cell.itemMinusBtn.isHidden = true
                cell.itemPlusBtn.isHidden = false
                return cell
                
            }else { // show reamianing mius cell
                let cell = tableView.dequeueReusableCell(withIdentifier: "DeliveryDetailsTwoTableViewCell") as! DeliveryDetailsTwoTableViewCell
                
                cell.itemMinusTaped = {
                    self.userInputs.remove(at: indexPath.item - 1)
                    self.tableView.reloadSections(IndexSet(integer: 2), with: .none)
                }
                
                cell.textFieldValueChangged = { value in
                    self.textFieldValueChangged(value: value, index: indexPath.item)
                }
                
                cell.setValue(value: userInputs[indexPath.item - 1])
                cell.itemMinusBtn.isHidden = false
                cell.itemPlusBtn.isHidden = true
                return cell
            }
            
        
            
            
        }
     
        return UITableViewCell()
    }
}



*/
