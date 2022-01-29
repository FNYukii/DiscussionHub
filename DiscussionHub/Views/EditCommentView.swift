//
//  EditCommentView.swift
//  DiscussionHub
//
//  Created by Yu on 2022/01/29.
//

import SwiftUI

struct EditCommentView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let parentThreadId: String
    let comment: Comment
    @State var newContent = ""
    
    init(parendThreadId: String, comment: Comment) {
        self.parentThreadId = parendThreadId
        self.comment = comment
        print("HELLO! parentThreadId: \(parendThreadId)")
        _newContent = State(initialValue: self.comment.content)
    }
    
    var body: some View {
        
        NavigationView {
            Form {
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $newContent)
                    Text("コメント")
                        .foregroundColor(Color(UIColor.placeholderText))
                        .opacity(newContent.isEmpty ? 1 : 0)
                        .padding(.top, 8)
                        .padding(.leading, 5)
                }
                
                Section {
                    Button("コメントを削除") {
                        // TODO: Delete comment
                        let commentViewModel = CommentViewModel()
                        commentViewModel.deleteComment(threadId: parentThreadId, commentId: comment.id)
                    }
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, alignment: .center)
                }
               
            }
            .navigationBarTitle("コメントを編集", displayMode: .inline)
            .navigationBarItems(
                leading: Button("キャンセル"){
                    dismiss()
                },
                trailing:  Button(action: {
                    // TODO: Update comment
                    let commentViewModel = CommentViewModel()
                    commentViewModel.updateComment(threadId: parentThreadId, commentId: comment.id, commentContent: newContent)
                    dismiss()
                }){
                    Text("完了")
                        .fontWeight(.bold)
                }
                    .disabled(newContent.isEmpty)
            )
        }
    }
}
