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
            FirstView()
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Connect to Firebase
        FirebaseApp.configure()
        
        // At the first startup, create userId
        let userId = UserDefaults.standard.string(forKey: "userId")
        if userId == nil {
            let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
            let newUserId = String((0..<10).map{ _ in characters.randomElement()! })
            UserDefaults.standard.set(newUserId, forKey: "userId")
        }
        
        //TextEditorなどの背景色を非表示
        UITextView.appearance().backgroundColor = .clear
        
        return true
    }
}
