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
    @State var title = ""
    
    init(thread: Thread) {
        self.thread = thread
        _title = State(initialValue: self.thread.title)
    }
    
    var body: some View {
        
        NavigationView {
            Form {
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $title)
                    Text("タイトル")
                        .foregroundColor(Color(UIColor.placeholderText))
                        .opacity(title.isEmpty ? 1 : 0)
                        .padding(.top, 8)
                        .padding(.leading, 5)
                }
                
                Section {
                    Button("スレッドを削除") {
                        // TODO: Delete thread
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
                    // TODO: Update thread
                    dismiss()
                }){
                    Text("完了")
                        .fontWeight(.bold)
                }
                    .disabled(title.isEmpty)
            )
        }
    }
}
