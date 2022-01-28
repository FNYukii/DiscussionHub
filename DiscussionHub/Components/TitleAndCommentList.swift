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
    
    var body: some View {
        
        List {
            
            // Thread title
            Button(action: {
                // TODO: Open EditThreadView
            }) {
                Text(threadViewModel.currentThread!.title)
                    .font(.title)
                    .fontWeight(.bold)
            }
            .buttonStyle(PlainButtonStyle())
            
            // Comments
            ForEach(commentViewModel.comments, id: \.self) {comment in
                VStack(alignment: .leading) {
                    Divider()
                    HStack {
                        Text("\(comment.order)")
                            .fontWeight(.semibold)
                        Text(comment.userId)
                            .fontWeight(.semibold)
                        Text("\(formatDate(inputDate: comment.createdAt))")
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal, 12)
                    
                    Button(action: {
                        // TODO: Open EditCommentView
                    }) {
                        Text(comment.content)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom, 6)
                            .padding(.horizontal, 12)
                    }
                    .buttonStyle(PlainButtonStyle())
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
        dateFormatter.dateFormat = "yyyy-MM-dd E HH:mm:ss"
        return dateFormatter.string(from: inputDate)
    }
}
