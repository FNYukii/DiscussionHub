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
    @State var isShowEditThreadSheet = false
    @State var isShowEditCommentSheet = false
    
    var body: some View {
        
        List {
            
            // Thread title
            Button(action: {
                isShowEditThreadSheet.toggle()
            }) {
                Text(threadViewModel.currentThread!.title)
                    .font(.title)
                    .fontWeight(.bold)
            }
            .buttonStyle(PlainButtonStyle())
            .disabled(threadViewModel.currentThread!.authorId != userId)
            
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
                    }
                    .padding(.horizontal, 12)
                    
                    Button(action: {
                        // TODO: Open EditCommentView
                        isShowEditCommentSheet.toggle()
                    }) {
                        Text(comment.content)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom, 6)
                            .padding(.horizontal, 12)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .disabled(comment.authorId != userId)
                }
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
                .padding(6)
            }
        }
        .listStyle(PlainListStyle())
        
        .sheet(isPresented: $isShowEditThreadSheet) {
            EditThreadView(thread: threadViewModel.currentThread!)
        }
        .sheet(isPresented: $isShowEditCommentSheet) {
//            EditCommentView()
        }
        
    }
    
    func formatDate(inputDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd E HH:mm:ss"
        return dateFormatter.string(from: inputDate)
    }
}
