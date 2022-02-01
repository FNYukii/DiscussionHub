//
//  DiscussionHubApp.swift
//  DiscussionHub
//
//  Created by Yu on 2022/01/27.
//

import SwiftUI
import Firebase
import FirebaseAuth

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
        
        // Log in
        Auth.auth().signInAnonymously()
        
        // At the first startup, create userId
        let userDisplayname = UserDefaults.standard.string(forKey: "userDisplayname")
        if userDisplayname == nil {
            let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
            let newUserDisplayname = String((0..<10).map{ _ in characters.randomElement()! })
            UserDefaults.standard.set(newUserDisplayname, forKey: "userDisplayname")
        }
        
        //TextEditorなどの背景色を非表示
        UITextView.appearance().backgroundColor = .clear
        
        return true
    }
}
