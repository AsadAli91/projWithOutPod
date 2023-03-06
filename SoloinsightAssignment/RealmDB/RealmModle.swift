//
//  RealmModle.swift
//  SoloinsightAssignment
//
//  Created by Asad on 27/02/2023.
//

import Foundation
import RealmSwift


class SignUPModelRealm: Object{
    
    @Persisted(primaryKey: true) var id = 0
    @Persisted var userFirstName = ""
    @Persisted var userLastName = ""
    @Persisted var userEmail = ""
    @Persisted var userPassword = ""
    @Persisted var userConfirmPassword = ""
    @Persisted var userImage = Data()
    
    
    convenience init(id: Int = 0, userFirstName: String = "", userLastName: String = "", userEmail: String = "", userPassword: String = "", userConfirmPassword: String = "", userImage: Data) {
        
        self.init()
        
        self.id = id
        self.userFirstName = userFirstName
        self.userLastName = userLastName
        self.userEmail = userEmail
        self.userPassword = userPassword
        self.userConfirmPassword = userConfirmPassword
        self.userImage = userImage
    }
}



/*
func addWorkingStepNotification(){
    
    let fetchWorkingStepsListData = realmDB().fetchData(WorkingPlanStepsListDetailRealm.self)
    var params: [String: Any] = [String: Any]()
    params["c_id"] = getId
    
    WorkingListDetailsViewModel.shared.getJobListDetailData(params: params) { response, message in
        guard let workingSteps = response as? [ListDetailData] else {return}
        
        workingSteps.forEach { workingStepsList in
            
            if !(fetchWorkingStepsListData.contains(where: { $0.c_id == workingStepsList.c_id})) {
                RealmHelper.shared.saveWorkingPlanStepsListDetailRealm([workingStepsList], self.getId)
                self.getWrokingPlanData()
            }
        }
    }
}
 
 
 
 
 
 let predicate = NSPredicate(format: "userEmail == %@", signUPModelRealm.userEmail)
 print(realmDB().fetchData(SignUPModelRealm.self, predicate))
 print(signUPModelRealm)
*/
