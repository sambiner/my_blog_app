//
//  slightly_meatier_bonesApp.swift
//  slightly-meatier-bones
//
//  Created by keckuser on 4/2/23.
//

import SwiftUI

@main
struct SlightlyMeatierBonesApp: App {
    @UIApplicationDelegateAdaptor(SlightlyMeatyBlogAppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(SlightlyMeatyAuth())
                .environmentObject(SlightlyMeatyBlogArticle())
        }
    }
}
