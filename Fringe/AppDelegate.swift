//
//  AppDelegate.swift
//  Adelaide FringeTests
//
//  Created by Pham, Duy Anh - phady026 on 8/11/20.
//  Copyright © 2020 Pham, Duy Anh - phady026. All rights reserved.
// 

import UIKit
import GoogleMaps
import GooglePlaces
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        
        GMSServices.provideAPIKey("AIzaSyDcuShbzd-jHDcqQNCwSl9659rvG1pjuYA")
        GMSPlacesClient.provideAPIKey("AIzaSyDcuShbzd-jHDcqQNCwSl9659rvG1pjuYA")
        
        return true
    }

    func gotoHomePage() {
        if let vc = UIApplication.shared.windows.first!.rootViewController?.storyboard?.instantiateViewController(withIdentifier: "NavHome") {
            UIApplication.shared.windows.first!.rootViewController = vc
        }
    }
    
}

