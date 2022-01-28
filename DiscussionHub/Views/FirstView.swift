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
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(threadViewModel.threads) {thread in
                    NavigationLink(destination: ThreadView(threadId: thread.id)) {
                        Text(thread.title)
                    }
                }
            }
                .sheet(isPresented: $isShowSheet) {
                    CreateThreadView()
                }
                .navigationBarTitle("スレッド")
                .navigationBarItems(
                    trailing: Button(action: {
                        isShowSheet.toggle()
                    }){
                        Image(systemName: "plus.circle.fill")
                        Text("New thread")
                    }
                )
        }
    }
}
