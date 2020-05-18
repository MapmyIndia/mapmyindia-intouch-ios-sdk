
# MapmyIndia Intouch iOS SDK

## Introduction

MapmyIndia Intouch  will enable the live tracking functionality in your mobile app and allows you to get the powerful features from Intouch IoT platform for your telematics devices. Inotuch SDK for iOS lets you easily add MapmyIndia Telematics cloud services to your own iOS application.

Using this SDK, Your app shall fetch the live location from the end user mobile phone at the predefined condition, It could be based on the movement of the user, or fixed time interval or the combination of both. You can customize the data polling conditions. Along with that  you can get the details about your other telematics device live locaion and analytics around that.

You will get seemless location benifits which caterted to different domains like `logistics`, `delivery tracking` , `Employee tracking` , `live location sharing`  etc.

-  [Publishable Key](https://apisupport@mapmyindia.com) Get your Publishable Key please contact from apiSupport url (https://apisupport@mapmyindia.com)

-  [Quickstart](https://github.com/MapmyIndia) Start with a ready-to-go app

-  [Integrate the SDK](#AddBeaconTrackingSDK) Integrate the SDK into your app

-  [Dashboard](https://intouch.mapmyindia.com/nextgen/#/home/dashboard) See all your devices' locations on MapmyIndia Intouch Dashboard

## Get your Publishable Key.

We use your Publishable key to identify your account details and assign all your users device under single account.

https://www.mapmyindia.com/api/login?appmyindia-dashboard to get your publishable Key.

After getting the `publishable key`, you can [start with the IntouchDemo app](https://github.com/MapmyIndia), or [Integrate the Intouch SDK](https://github.com/MapmyIndia/mapmyindia-intouch-ios-sdk)  in your app.


## Setup a Project

This guide allows you to add a live location tracking to an iOS app.

[Xcode IDE]() recommended `Xcode 11.0` only.

Step 1. Download the IntouchDemo App.

to download the IntouchDemo App Project. And then open this project.

**NOTE**:- This is only applicable in Demo app
```
Drag and Drop the SampleTest-Bridging.h file (which is provided in the project) to your Briding Header in Build Setting of the project.
```

Step 2. Set your Publishable key / Project Initiation

Add the publishable key to [My ViewController]() file.

## IOS_13 LOCATION PERMISSION

For Privacy Policy of Location

Location Permission Map Prompt(Always allow)

For apps granted Always Allow location permissions, iOS 13 will periodically display a “map prompt” The “map prompt” displays the location points collected by the app. In testing, we’ve identified that this prompt will be triggered after 3 consecutive days of background location use, and will continue to appear periodically with continued use.

**Add Location permission into your plist file**

`requestAlwaysAuthorization`
</br>
`requestWhenInUseAuthorization`

1. Add `transport security` settings Into your `plist file`.

2. Add `ProviderID(UDID)` and `token(DeviceToken)` to Info.plist file this can be any random value according to your choice.

3. Run project on your device use simulator instance.

Step 3. Check your location on the Intouch [dashboard](https://intouch.mapmyindia.com/nextgen)

## Setup a project

1.  Open Xcode Project.
2.  Create a new project as follows:
      -  Create New Application
      -  Select Single Application
      -  Select Next

3.  Enter your app name, project location,Bundle Indentifier language(Swift) and minimum API version as prompted. Then click  **Next**.

After this Xcode will contain two files viewcontroller& Appdelegate, Setting , StartBeacon

4. Create Setting and Start Beacon Screen Through Storyboard(Reference demo app for this.)

5. Go to `framework and libraries option` in `General Settings` of the project click on embeded and sign-in.

6. In capabilities  go to  background mode it should be enabled background fetch,&  location  updates.

#### Add following compulsory lines to your applications for Upload app on Store
```
Drag and drop Strip-frameworks.sh file in project  to run script in build phase.
File path is ------ bash "yourStripFIlePath/strip-frameworks.sh"
```

**APP delegate**

Add below function for fetch background data

```
func  application(_ application: UIApplication,performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
OpenLocate.shared.performFetchWithCompletionHandler(completionHandler)
}
```

## Initialize InTouch SDK

Initialize the SDK with your [Publishable Key](Test)

#### Add your Publisher key in client Id and Client Secret and add deviceName.
```
Intouch.shared.intouchInitilization(clientID: "", ClientSecret: "", successResponse: { (Success) in print(Success) }) { (error) in print(error?.localizedDescription) } }

```
`Client ID` and `Client Secret` it will contain the  `Publisher Key`.
After Successful get the token we  hit the api  for create device. after this you get the traking code
// set your device name for tracking this device name will be show on Intouch panel.

### Create device

After successful API confirmation we get tracking code for Track the location.

You cannot use the MapmyIndia Intouch SDK without these function calls. You will find your keys in your [API Dashboard](http://www.mapmyindia.com/api/dashboard).

There are option to add vehicle Type and Tracking Mode without choose these option tracking will not start.

**Location Permission**

Add these lines into your Controller file
```
Import CoreLocation
Import beaconframework

Set delegate  UNUserNotificationCenterDelegate  private  let  locationManager = CLLocationManager()

override  func  viewDidLoad() {
super.viewDidLoad()
if  Intouch().shared.isTrackingEnabled {
onStartTracking()
}

locationManager.delegate = self 

private  func  storedAuthorizationStatus() -> CLAuthorizationStatus {
let authorizationStatusRaw = Int32(UserDefaults.standard.integer(forKey: "AuthorizationStatus"))
return  CLAuthorizationStatus(rawValue: authorizationStatusRaw) ?? .authorizedAlways
}

func  locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
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
```
#### Call the below method to track your app user's phone live location. Make sure your internet connection  will be on that time.

```
Intouch().StartTracking()
```
####  Call the below method to Stop Track your app user's phone live location.
We put these lines for stop beacon tracking  and  sensors  like gyro, aceelerometer., barometer , motion detectors.

```
Intouch.shared.stopTracking()
option Redirect To Intouch
```
Set Vehicle type and Priority configration from below code

```
 Intouch().IntouchUserGender(gender: "")
 Intouch().IntouchVehicleType(vehicleType: "")
 Intouch().pollingConfigrationMode(priority: "")
```



README.md
Displaying README.md.
