//
//  FirstView.swift
//  DiscussionHub
//
//  Created by Yu on 2022/01/27.
//

import SwiftUI
import Firebase

struct FirstView: View {
    
    @ObservedObject var threadViewModel = ThreadViewModel()
    @State var isShowSheet = false
    
    init() {
        
        threadViewModel.startListenThreads()
        print("HELLO! FirstView initialized")
    }
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(threadViewModel.allThreads) {thread in
                    NavigationLink(destination: ShowThreadView(thread: thread)) {
                        Text(thread.title)
                    }
                }
            }
            .onDisappear {
                print("HELLO! List disappeared")
            }
            .onAppear {
                print("HELLO! List appeared")
            }
            
            .sheet(isPresented: $isShowSheet) {
                CreateThreadView()
            }
            .navigationBarTitle("スレッド")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowSheet.toggle()
                    }){
                        Image(systemName: "plus.circle.fill")
                        Text("新規スレッド")
                    }
                }
            }
        }
    }
}
