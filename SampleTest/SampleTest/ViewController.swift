//
//  ViewController.swift
//  SampleTest
//
//  Created by CEINFO on 03/09/19.
//  Copyright © 2019 CEINFO. All rights reserved.
//

import UIKit
import SystemConfiguration.CaptiveNetwork
import CoreMotion
import NetworkExtension
import CoreTelephony.CTCarrier
import SVProgressHUD
import UserNotifications
import CoreLocation
import BeaconSdkFramework

struct getSettingData {
    static var VehicleType = ""
    static var gender = ""
    static var periority = ""
}

class ViewController: UIViewController,CLLocationManagerDelegate,UNUserNotificationCenterDelegate {
   
    @IBOutlet weak var deviceNameTxt: UITextField!
    @IBOutlet weak var btnInitilizeToken: UIButton!
    @IBOutlet weak var txtTokenKey: UITextField!

    @IBAction func btnGetToken(_ sender: Any) {
    
      //  self.intouchDecicetoke()
        let deviceName = deviceNameTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let publisherkey = txtTokenKey.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if deviceName == "" && publisherkey == ""
        {
             let alert = UIAlertController(title: "Alert", message: "DeviceName&Publisherkey can't be blank", preferredStyle: UIAlertControllerStyle.alert)
             alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
             self.present(alert, animated: true, completion: nil)
              return
        }
        
        let trackCode = UserDefaults.standard.string(forKey: "TrackCode")
         if trackCode == nil
         {
            self.getCreateDeviceToken()
         }
        else
         {
            self.txtTokenKey.text = trackCode
         }
     
    }
    func getCreateDeviceToken()
    {
         SVProgressHUD.show()
         let publisherkey = self.txtTokenKey.text ?? ""
         let deviceNameNew = self.deviceNameTxt.text ?? ""
        Intouch.shared.intouchInitilization(clientID: "", clientSecret: "", successResponse: { (success) in
            print("")
             SVProgressHUD.dismiss()
             self.enableConfigration()
        }) { (error) in
            print("")
             SVProgressHUD.dismiss()
        }
    }
    
  
    func enableConfigration()
    {
         let trackCode = UserDefaults.standard.string(forKey: "TrackCode")
         if trackCode == nil
          {
            self.txtTokenKey.isHidden = false
            
            deviceNameTxt.isEnabled = true
            deviceNameTxt.alpha = 1.0
      
            
            btnInitilizeToken.isEnabled = true
            btnInitilizeToken.alpha = 1.0
            
          }
        else
         {
            //self.txtTokenKey.isHidden = false
             self.txtTokenKey.isHidden = false
            
            deviceNameTxt.isEnabled = false
            deviceNameTxt.alpha = 0.5
            btnInitilizeToken.isEnabled = false
            btnInitilizeToken.alpha = 0.5
            
            self.txtTokenKey.text = trackCode
         
            let vctrl = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StartBeaconVC") as? StartBeaconVC
            self.navigationController?.pushViewController(vctrl!, animated: true)
            
         }
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
    
    override func viewWillAppear(_ animated: Bool) {
    
         let deviceType = UserDefaults.standard.string(forKey: "DeviceName")
         deviceNameTxt.text = deviceType
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        btnInitilizeToken.layer.cornerRadius = 6.0
        btnInitilizeToken.layer.borderWidth = 1.0
        btnInitilizeToken.layer.borderColor = UIColor(red: 227/255.0, green: 227/255.0, blue: 227/255.0, alpha: 1.0).cgColor
              
        deviceNameTxt.delegate = self
        self.enableConfigration()
        self.navigationItem.title = "Initilization"
    }
}

    public class Reachability {
        
        class func isConnectedToNetwork() -> Bool {
            
            var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
            zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
            zeroAddress.sin_family = sa_family_t(AF_INET)
            
            let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
                $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                    SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
                }
            }
            
            var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
            if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
                return false
            }
            
            /* Only Working for WIFI
             let isReachable = flags == .reachable
             let needsConnection = flags == .connectionRequired
             
             return isReachable && !needsConnection
             */
            
            // Working for Cellular and WIFI
            let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
            let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
            let ret = (isReachable && !needsConnection)
            
            return ret
        }
    }

extension String {
  func replace(string:String, replacement:String) -> String {
      return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
  }

  func removeWhitespace() -> String {
      return self.replace(string: " ", replacement: "")
  }
}

extension ViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
       }
}



