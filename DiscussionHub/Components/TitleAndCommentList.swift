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
    
    var body: some View {
        
        List {
            
            // Thread title
            Text(threadViewModel.currentThread!.title)
                .font(.title)
                .fontWeight(.bold)
            
            // Comments
            ForEach(commentViewModel.comments, id: \.self) {comment in
                VStack(alignment: .leading) {
                    Divider()
                    HStack {
                        Text("\(comment.order)")
                            .fontWeight(.semibold)
                        Text(comment.authorId)
                            .fontWeight(.semibold)
                        Text("\(formatDate(inputDate: comment.createdAt))")
                            .foregroundColor(.secondary)
                        Spacer()
                        
                        Menu {
                            Button(action: {
                                // TODO: Bookmark comment
                            }){
                                Label("ブックマークに追加", systemImage: "bookmark")
                            }
                            if comment.authorId == userId {
                                Button(role: .destructive) {
                                    // TODO: Delete comment
                                } label: {
                                    Label("コメントを削除", systemImage: "trash")
                                }
                            } else {
                                Button(action: {
                                    // TODO: Mute user
                                }){
                                    Label("\(comment.authorId)さんをミュート", systemImage: "flag")
                                }
                            }
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundColor(.secondary)
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
