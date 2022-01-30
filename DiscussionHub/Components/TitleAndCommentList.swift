//
//  CommentList.swift
//  DiscussionHub
//
//  Created by Yu on 2022/01/28.
//

import SwiftUI

struct TitleAndCommentList: View {
    
    @ObservedObject var threadViewModel: ThreadViewModel
    @ObservedObject var commentViewModel: CommentViewModel
    
    let userId = UserDefaults.standard.string(forKey: "userId")
    @State var isShowDeleteCommentConfirmation = false
    
    var body: some View {
        
        List {
            
            // Thread title
            Text(threadViewModel.currentThread!.title)
                .font(.title)
                .fontWeight(.bold)
            
            // Comments
            ForEach(commentViewModel.comments, id: \.self) {comment in
                VStack(alignment: .leading, spacing: 0) {
                    Divider()
                        .padding(.bottom, 6)
                    HStack() {
                        Text("\(comment.order)")
                            .fontWeight(.semibold)
                        Text(comment.authorId)
                            .fontWeight(.semibold)
                        Text("\(formatDate(inputDate: comment.createdAt))")
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                        Spacer()
                        
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
                            if comment.authorId == userId {
                                Button(role: .destructive) {
                                    isShowDeleteCommentConfirmation.toggle()
                                } label: {
                                    Label("コメントを削除", systemImage: "trash")
                                }
                            } else {
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
                    }
                    .padding(.horizontal, 12)
                    
                    Text(comment.content)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.bottom, 6)
                        .padding(.horizontal, 12)
                }
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
                .padding(6)
                .confirmationDialog("", isPresented: $isShowDeleteCommentConfirmation, titleVisibility: .hidden) {
                    Button("コメントを削除", role: .destructive) {
                        // TODO: Delete comment
                        print("HELLO I will delete \(comment.content)")
                    }
                } message: {
                    Text("このコメントを削除してもよろしいですか?")
                }
            }
        }
        .listStyle(PlainListStyle())
    }
    
    func formatDate(inputDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd E HH:mm"
        return dateFormatter.string(from: inputDate)
    }
}
