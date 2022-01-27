//
//  ContentView.swift
//  DiscussionHub
//
//  Created by Yu on 2022/01/27.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationView {
            TabView {
                FirstView()
                    .tabItem {
                        Label("home", systemImage: "house")
                    }
                SecondView()
                    .tabItem {
                        Label("Star", systemImage: "star")
                    }
                ThirdView()
                    .tabItem {
                        Label("Notice", systemImage: "bell")
                    }
            }
        }
    }
}
