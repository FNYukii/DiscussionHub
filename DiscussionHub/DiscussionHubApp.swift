//
//  DiscussionHubApp.swift
//  DiscussionHub
//
//  Created by Yu on 2022/01/27.
//

import SwiftUI
import Firebase

@main
struct DiscussionHubApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Connect to Firebase
        FirebaseApp.configure()
        
        return true
    }
}
