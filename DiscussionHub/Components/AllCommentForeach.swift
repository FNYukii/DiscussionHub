//
//  AllCommentList.swift
//  DiscussionHub
//
//  Created by Yu on 2022/01/31.
//

import SwiftUI

struct AllCommentForeach: View {
    
    let showingThread: Thread
    let allComments: [Comment]
    
    var body: some View {
        ForEach(allComments, id: \.self) {comment in
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
                    CommentMenu(parentThreadId: showingThread.id, comment: comment)
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
    
    func formatDate(inputDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd E HH:mm"
        return dateFormatter.string(from: inputDate)
    }
}
