//
//  ContentView.swift
//  DiscussionHub
//
//  Created by Yu on 2022/01/27.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            FirstView()
                .tabItem {
                    Label("スレッド", systemImage: "rectangle.portrait.on.rectangle.portrait")
                }
            SecondView()
                .tabItem {
                    Label("お気に入り", systemImage: "star")
                }
            ThirdView()
                .tabItem {
                    Label("通知", systemImage: "bell")
                }
        }
    }
}
