//
//  CommentMenu.swift
//  DiscussionHub
//
//  Created by Yu on 2022/01/30.
//

import SwiftUI
import FirebaseAuth

struct CommentMenu: View {
    
    let showingComment: Comment
    
    let userId = Auth.auth().currentUser?.uid ?? ""
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
            if showingComment.authorId == userId && showingComment.order != 1{
                Button(role: .destructive) {
                    selectedCommentId = showingComment.id
                    isShowDeleteCommentConfirmation.toggle()
                } label: {
                    Label("コメントを削除", systemImage: "trash")
                }
            }
            if showingComment.authorId != userId {
                Button(action: {
                    // TODO: Mute user
                }){
                    Label("\(showingComment.authorDailyId)さんをミュート", systemImage: "speaker.slash")
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
                CommentViewModel.deleteComment(parentThreadId: showingComment.parentThreadId, commentId: selectedCommentId)
            }
        } message: {
            Text("このコメントを削除してもよろしいですか?")
        }
        
    }
}
