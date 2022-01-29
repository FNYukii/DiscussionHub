//
//  EditThreadView.swift
//  DiscussionHub
//
//  Created by Yu on 2022/01/29.
//

import SwiftUI

struct EditThreadView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let thread: Thread
    @State var newTitle = ""
    
    init(thread: Thread) {
        self.thread = thread
        _newTitle = State(initialValue: self.thread.title)
    }
    
    var body: some View {
        
        NavigationView {
            Form {
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $newTitle)
                    Text("タイトル")
                        .foregroundColor(Color(UIColor.placeholderText))
                        .opacity(newTitle.isEmpty ? 1 : 0)
                        .padding(.top, 8)
                        .padding(.leading, 5)
                }
                
                Section {
                    Button("スレッドを削除") {
                        let threadViewModel = ThreadViewModel()
                        threadViewModel.deleteThread(threadId: thread.id)
                        dismiss()
                    }
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, alignment: .center)
                }
               
            }
            .navigationBarTitle("スレッドを編集", displayMode: .inline)
            .navigationBarItems(
                leading: Button("キャンセル"){
                    dismiss()
                },
                trailing:  Button(action: {
                    let threadViewModel = ThreadViewModel()
                    threadViewModel.updateThread(threadId: thread.id, threadTitle: newTitle)
                    dismiss()
                }){
                    Text("完了")
                        .fontWeight(.bold)
                }
                    .disabled(newTitle.isEmpty)
            )
        }
    }
}
