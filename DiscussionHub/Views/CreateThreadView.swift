//
//  CreateDiscussionView.swift
//  DiscussionHub
//
//  Created by Yu on 2022/01/27.
//

import SwiftUI
import Introspect

struct CreateThreadView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var title = ""
    @State var firstCommentContent = ""
    
    var body: some View {
        NavigationView {
            Form {
                                
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $title)
                        .introspectTextView { textEditor in
                            textEditor.becomeFirstResponder()
                        }
                    Text("タイトル")
                        .foregroundColor(Color(UIColor.placeholderText))
                        .opacity(title.isEmpty ? 1 : 0)
                        .padding(.top, 8)
                        .padding(.leading, 5)
                }
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $firstCommentContent)
                    Text("最初のコメント")
                        .foregroundColor(Color(UIColor.placeholderText))
                        .opacity(firstCommentContent.isEmpty ? 1 : 0)
                        .padding(.top, 8)
                        .padding(.leading, 5)
                }
                
            }
            .navigationBarTitle("新規スレッド", displayMode: .inline)
            .navigationBarItems(
                leading: Button("キャンセル"){
                    dismiss()
                },
                trailing:  Button(action: {
                    let threadViewModel = ThreadViewModel()
                    threadViewModel.addThread(title: title, firstCommentContent: firstCommentContent)
                    dismiss()
                }){
                    Text("作成")
                        .fontWeight(.bold)
                }
                    .disabled(title.isEmpty || firstCommentContent.isEmpty)
            )
        }
    }
}
