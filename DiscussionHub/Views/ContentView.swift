//
//  ContentView.swift
//  DiscussionHub
//
//  Created by Yu on 2022/01/27.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var threadViewModel = ThreadViewModel()
    @State var isShowCreateThreadSheet = false
    @State var isShowUserSettingSheet = false
    
    init() {
        threadViewModel.startListeningThreads()
    }
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(threadViewModel.allThreads) {thread in
                    NavigationLink(destination: ShowThreadView(showingThread: thread)) {
                        Text(thread.title)
                    }
                }
            }
            
            .sheet(isPresented: $isShowCreateThreadSheet) {
                CreateThreadView()
            }
            .sheet(isPresented: $isShowUserSettingSheet) {
                UserSettingView()
            }
            
            .navigationBarTitle("スレッド")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowCreateThreadSheet.toggle()
                    }){
                        Image(systemName: "plus.circle.fill")
                        Text("新規スレッド")
                    }
                }
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button(action: {
                        isShowUserSettingSheet.toggle()
                    }){
                        Image(systemName: "person.crop.circle")
                            .font(.title3)
                    }
                }
            }
        }
    }
}
