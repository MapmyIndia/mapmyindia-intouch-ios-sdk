//
//  SettingVC.swift
//  SampleTest
//
//  Created by CE00078515 on 12/12/19.
//  Copyright © 2019 CEINFO. All rights reserved.
//

import UIKit
import BeaconSdkFramework
class SettingVC: UIViewController {

    private let intervals = [60.0, 300.0, 3600.0, 21600.0, 43200.0, 86400.0]
 
    private let GenderArr = ["Male", "Female"]
    private let Priority = ["Fast", "Slow", "Optimal"]
    
      var settingType : String = ""
      var PrioritySettingArr = [String]()
    
    @IBOutlet weak var tblChooseSetting: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tblChooseSetting.register(UINib(nibName: "SettingCell", bundle: nil), forCellReuseIdentifier: "SettingCell")
        if settingType == "VehicleType"
        {
            var VehicleType : [NSString]
            VehicleType =  ["Pedestrain", "2 Wheeler", "3 Wheeler", "4 Wheeler"]
            
            PrioritySettingArr = VehicleType as [String]
        }
        else if settingType == "Gender"
        {
             PrioritySettingArr = GenderArr
        }
        else
        {
             PrioritySettingArr = Priority
        }
        // Do any additional setup after loading the view.
    }
}

//MARK: TABLE_DELEGATE&DATASOURCE
extension SettingVC: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if PrioritySettingArr.count > 0
        {
            return PrioritySettingArr.count
        }
        return 0
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          
         let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell") as? SettingCell
         cell?.lblSettingTitle?.text = PrioritySettingArr[indexPath.row]
        return cell!
      }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        if settingType == "VehicleType"
        {
            let VehicleType = PrioritySettingArr[indexPath.row]
             getSettingData.VehicleType = VehicleType
            SetConfigration().setAdditionalConfigVehicleType(vehicleType: VehicleType)
            self.navigationController?.popViewController(animated: true)
        }
        else if settingType == "Gender"
        {
               let gender = PrioritySettingArr[indexPath.row]
               SetConfigration().setAdditionalConfigGender(gender: gender)
                getSettingData.gender = gender
               self.navigationController?.popViewController(animated: true)
        }
        else if settingType == "Priority"
        {
              let setPriority = PrioritySettingArr[indexPath.row]
                 getSettingData.periority = setPriority
             SetConfigration().setAdditionalConfigPriority(Priority: setPriority)
             self.navigationController?.popViewController(animated: true)
            
        }
    }
    
}


