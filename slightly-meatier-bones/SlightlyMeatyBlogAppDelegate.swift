//
//  SlightlyMeatyBlogAppDelegate.swift
//  slightly-meatier-bones
//
//  Created by keckuser on 4/2/23.
//

import Foundation
import UIKit

import Firebase
import GoogleSignIn

class SlightlyMeatyBlogAppDelegate: NSObject, UIApplicationDelegate {
    func application(_ app: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if error != nil || user == nil{
                
            } else {  }
        }
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}
