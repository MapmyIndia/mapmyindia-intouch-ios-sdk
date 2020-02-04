# SAMPLE TRACKING SWIFT SDK

This is a sample project for raster Map follow the below steps for integrate the same.

Steps for adding Raster SDK frameworks in Swift project:

1.    Create an iOS Application project base on Swift programming language.
2.    Drag and drop the MapmyIndia Map SDK framework (MMIFramework.framework) and resource bundle file 
3.        Add these dependencies to your project (Build Phases > Link Binary with Libraries) -
libsqlite3.0.dylib
libz.dylib
4.        Add compiler flag (Project target > Build Settings > Other Linker Flags > Set `-ObjC`)
5.    For iOS8 or later, make this change to your info.plist (Project target > info.plist > Add row and set key 
`NSLocationWhenInUseUsageDescription`)
6.    Add a new CocoaTouch Objective C (NSObject) class in your project.
7.    Xcode will prompt for adding Objective-C Bridging Header file. On confirmation by clicking on     “Create Bridging Header” it will add an Objective-C file in your project and name will be name of     your product followed by “-Bridging-Header.h”. Alternatively, you can create a bridging header yourself by choosing File > New >     File > [operating system] > Source > Header File.
8.    Edit the bridging header to expose your Objective-C code to your Swift code:
In your Objective-C bridging header, import MMIFramework to expose to Swift by using below line of code:
#import <MMIFramework/MMIFramework.h>
9.        In Build Settings, in Swift Compiler - Code Generation, make sure the Objective-C Bridging Header build setting has a path to the bridging header file. The path should be relative to your project, similar to the way your Info.plist path is specified in Build Settings. In most cases, you won't need to modify this setting.


IOS 13 LOCATION PERMISSION
For Privacy Policy of Location
Valuable: The prompt explains why the user should grant location permissions, like enabling a valuable location-based feature.
Timely: The prompt is shown when the user is engaged, like in an onboarding, when accessing a location-based feature, or after a transaction. Background permission prompts are shown after and incremental to foreground permission prompts.

-: Location Permission Map Prompt
For apps granted Always Allow location permissions, iOS 13 will periodically display a “map prompt” (see below). The “map prompt” displays the location points collected by the app. In testing, we’ve identified that this prompt will be triggered after 3 consecutive days of background location use, and will continue to appear periodically with continued use.


FOR WIFI  INFO-
You can only access Wifi SSID in these three cases:
If your app has permission to access the location.
If your app has an enabled VPN profile.
If your app is a networking app that uses NEHotspotConfiguration. You will need extra approval from Apple for this case.
https://medium.com/better-programming/how-to-access-wifi-ssid-on-ios-13-using-swift-40c4bba3c81d


