//
//  CommentMenu.swift
//  DiscussionHub
//
//  Created by Yu on 2022/01/30.
//

import SwiftUI

struct CommentMenu: View {
    
    let parentThreadId: String
    let comment: Comment
    
    let userId = UserDefaults.standard.string(forKey: "userId")
    @State var isShowDeleteCommentConfirmation = false
    @State var selectedCommentId = ""
    
    var body: some View {
        Menu {
            Button(action: {
                // TODO: Bookmark comment
            }){
                Label("コメントをブックマークに追加", systemImage: "bookmark")
            }
            Button(action: {
                // TODO: Reply to comment
            }){
                Label("このコメントに返信", systemImage: "arrowshape.turn.up.left")
            }
            if comment.authorId == userId && comment.order != 1{
                Button(role: .destructive) {
                    selectedCommentId = comment.id
                    isShowDeleteCommentConfirmation.toggle()
                } label: {
                    Label("コメントを削除", systemImage: "trash")
                }
            }
            if comment.authorId != userId {
                Button(action: {
                    // TODO: Mute user
                }){
                    Label("\(comment.authorId)さんをミュート", systemImage: "speaker.slash")
                }
                Button(action: {
                    // TODO: Report comment
                }){
                    Label("コメントを報告する", systemImage: "flag")
                }
            }
        } label: {
            Image(systemName: "ellipsis")
                .foregroundColor(.secondary)
                .padding(.vertical, 6)
        }
        
        .confirmationDialog("", isPresented: $isShowDeleteCommentConfirmation, titleVisibility: .hidden) {
            Button("コメントを削除", role: .destructive) {
                let commentViewModel = CommentViewModel()
                commentViewModel.deleteComment(parentThreadId: parentThreadId, commentId: selectedCommentId)
            }
        } message: {
            Text("このコメントを削除してもよろしいですか?")
        }
        
    }
}
