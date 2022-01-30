//
//  ThreadMenu.swift
//  DiscussionHub
//
//  Created by Yu on 2022/01/30.
//

import SwiftUI

struct ThreadMenu: View {
    
    let thread: Thread
    
    let userId = UserDefaults.standard.string(forKey: "userId")
    @State var isShowDeleteThreadConfirmation = false

    var body: some View {
        Menu {
            Button(action: {
                // TODO: Bookmark comment
            }){
                Label("スレッドをブックマークに追加", systemImage: "bookmark")
            }
            if thread.authorId == userId {
                Button(role: .destructive) {
                    isShowDeleteThreadConfirmation.toggle()
                } label: {
                    Label("スレッドを削除", systemImage: "trash")
                }
            } else {
                Button(action: {
                    // TODO: Report thread
                }){
                    Label("スレッドを報告する", systemImage: "flag")
                }
            }
        } label: {
            Image(systemName: "ellipsis.circle")
        }
        
        .confirmationDialog("", isPresented: $isShowDeleteThreadConfirmation, titleVisibility: .hidden) {
            Button("スレッドを削除", role: .destructive) {
                let threadViewModel = ThreadViewModel()
                threadViewModel.deleteThread(threadId: thread.id)
            }
        } message: {
            Text("このスレッドを削除してもよろしいですか?").bold()
        }
        
    }
}
