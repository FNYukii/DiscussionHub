//
//  ShowCommentView.swift
//  DiscussionHub
//
//  Created by Yu on 2022/02/04.
//

import SwiftUI

struct ShowCommentView: View {
    
    let showingComment: Comment
    
    var body: some View {
        
        VStack {
            
            // One comment
            VStack(alignment: .leading, spacing: 0) {
                HStack() {
                    Text("\(showingComment.order)")
                        .fontWeight(.semibold)
                    if !showingComment.authorHandleName.isEmpty {
                        Text(showingComment.authorHandleName)
                            .fontWeight(.semibold)
                            .lineLimit(1)
                    }
                    Text("@\(showingComment.authorDailyId)")
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                    Spacer()
                    CommentMenu(showingComment: showingComment)
                }
                .padding(.horizontal, 12)
                Text(toFormatedDate(from: showingComment.createdAt))
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 12)
                Text(showingComment.content)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom, 6)
                    .padding(.horizontal, 12)
            }
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets())
            .padding(6)
        }
        
        Spacer()

        
        
    }
    
    private func toFormatedDate (from: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd E HH:mm:ss"
        return dateFormatter.string(from: from)
    }
    
}
