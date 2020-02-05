//
//  StartBeaconVC.swift
//  SampleTest
//
//  Created by CE00078515 on 01/02/20.
//  Copyright © 2020 CEINFO. All rights reserved.
//

import UIKit
import CoreLocation
import BeaconSdkFramework

class StartBeaconVC: UIViewController,CLLocationManagerDelegate,UNUserNotificationCenterDelegate {

    @IBOutlet weak var lblBottomMsg: UILabel!
    
    @IBOutlet weak var stopTrack: UIButton!
    @IBOutlet weak var startTrack: UIButton!
    @IBOutlet weak var btnTrackMode: UIButton!
    @IBOutlet weak var btnVehicleType: UIButton!
    
    @IBOutlet weak var bgViewVehicleType: UIView!
    @IBOutlet weak var bgviewTrackMode: UIView!
    @IBOutlet weak var bgViewBottomMsg: UIView!
    
      var timer = Timer()
    private let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bgviewTrackMode.layer.cornerRadius = 6.0
        bgviewTrackMode.layer.borderWidth = 1.0
        bgviewTrackMode.layer.borderColor = UIColor(red: 227/255.0, green: 227/255.0, blue: 227/255.0, alpha: 1.0).cgColor
        
        bgViewVehicleType.layer.cornerRadius = 6.0
        bgViewVehicleType.layer.borderWidth = 1.0
        bgViewVehicleType.layer.borderColor =  UIColor(red: 227/255.0, green: 227/255.0, blue: 227/255.0, alpha: 1.0).cgColor
        
        startTrack.layer.cornerRadius = 6.0
        startTrack.layer.borderWidth = 1.0
        startTrack.layer.borderColor = UIColor(red: 227/255.0, green: 227/255.0, blue: 227/255.0, alpha: 1.0).cgColor
        
        stopTrack.layer.cornerRadius = 6.0
        stopTrack.layer.borderWidth = 1.0
        stopTrack.layer.borderColor = UIColor(red: 227/255.0, green: 227/255.0, blue: 227/255.0, alpha: 1.0).cgColor
                
       self.navigationController?.navigationBar.isHidden = true
        
        if OpenLocate.shared.isTrackingEnabled {
            onStartTracking()
        }
        locationManager.delegate = self
        self.navigationItem.title = ""
        // Do any additional setup after loading the view.
    }
   
    @objc func beaconStartTimer() {
        // Something after a delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            
            self.bgViewBottomMsg.isHidden = false
            self.lblBottomMsg.alpha = 0
            [UIView.animate(withDuration: 2.0, delay: 1.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                self.lblBottomMsg.alpha = 1.0
            }, completion: { (finished) in
                [UIView.animate(withDuration: 2.0, delay: 1.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                    self.lblBottomMsg.alpha = 0
                }, completion: nil)]
            })]
        }
    }
    private func storedAuthorizationStatus() -> CLAuthorizationStatus {
           let authorizationStatusRaw = Int32(UserDefaults.standard.integer(forKey: "AuthorizationStatus"))
           return CLAuthorizationStatus(rawValue: authorizationStatusRaw) ?? .authorizedAlways
       }
    @IBAction func btnRedirectIntouch(_ sender: Any) {
        
        guard let url = URL(string: "https://intouch.mapmyindia.com/") else { return }
        UIApplication.shared.open(url)
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
        var vehicleName = getSettingData.VehicleType
        var Periority = getSettingData.periority
         if vehicleName == ""
        {
         vehicleName = "Vehicle Type"
        }
        if Periority == ""
         {
           Periority = "Tracking Mode"
         }
        if vehicleName == "" || Periority == ""
        {
            startTrack.isUserInteractionEnabled = false
        }
      
        btnVehicleType .setTitle(vehicleName, for: .normal)
        btnTrackMode .setTitle(Periority, for: .normal)
        
        // let deviceType = UserDefaults.standard.string(forKey: "DeviceName")
       //  deviceNameTxt.text = deviceType
    }
    
    @IBAction func vehicleType(_ sender: Any) {
    let vctrl = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingVC") as? SettingVC
         vctrl?.settingType = "VehicleType"
        
         self.navigationController?.pushViewController(vctrl!, animated: true)
    }
    
    @IBAction func stopTrack(_ sender: Any) {
        
               timer.invalidate()
               btnVehicleType.isEnabled = true
               btnVehicleType.alpha = 1.0
            
               btnTrackMode.isEnabled = true
               btnTrackMode.alpha = 1.0
               OpenLocate.shared.stopSensors()
               OpenLocate.shared.stopTracking()
               onStopTracking()
     }
    
    @IBAction func startTrack(_ sender: Any) {
        
        if btnVehicleType.titleLabel?.text == "Vehicle Type" || btnTrackMode.titleLabel?.text == "Tracking Mode"
               {
                   let alert = UIAlertController(title: "Alert", message: "Please choose configuration", preferredStyle: UIAlertControllerStyle.alert)
                   alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                   self.present(alert, animated: true, completion: nil)
                    return
               }
               else
               {
                   if !Reachability.isConnectedToNetwork(){
                       print("Internet Connection not Available!")
                       self.showAlert(status: "Msg", msg: "Internet Connection not Available!")
                   }
                   else
                   {
                       // SetConfigration().setAdditionalConfigPriority(Priority: "Fast")
                        btnVehicleType.isEnabled = false
                        btnVehicleType.alpha = 0.5
                    
                        btnTrackMode.isEnabled = false
                        btnTrackMode.alpha = 0.5
                       
                        SetConfigration().configureOpenLocate()
                        OpenLocate.shared.startTracking()
                        onStartTracking()
                        OpenLocate.shared.getGyroMeterData()
                        OpenLocate.shared.getAccelerometerData()
                        OpenLocate.shared.getBaroMeterData()
                    timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.beaconStartTimer), userInfo: nil, repeats: true)

                   }
               }
        
    }
    
    private func onStartTracking() {
         startTrack.isHidden = true
         stopTrack.isHidden = false
         //segment.isHidden = true
     }
     
     private func onStopTracking() {
         
         startTrack.isHidden = false
         stopTrack.isHidden = true
   
       //  segment.isHidden = true
     }
    @IBAction func btnTrackMode(_ sender: Any) {
        
        let vctrl = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingVC") as? SettingVC
              vctrl?.settingType = "Priority"
             self.navigationController?.pushViewController(vctrl!, animated: true)
        
    }
    
    func showAlert(status: String, msg: String)
       {
             let alert = UIAlertController(title: status, message: msg, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
             self.present(alert, animated: true, completion: nil)
             return
       }
       
       func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
           switch status {
           case .denied:
               self.showAlert(status: "Denied", msg: "The user explicitly denied the use of location service for this app or location service are currently disabled in Settings")
               return
           case .restricted :
                self.showAlert(status: "Restricted", msg: "The user has not yet made a choice regarding whether this app can use location services.")
               return
               
           default:
               return
           }
       }
}
