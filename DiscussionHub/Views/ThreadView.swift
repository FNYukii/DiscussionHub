//
//  OpinionsView.swift
//  DiscussionHub
//
//  Created by Yu on 2022/01/27.
//

import SwiftUI

struct ThreadView: View {
    
    let threadId: String
    let threadTitle: String
    @ObservedObject var commentViewModel: CommentViewModel
    
    @State var inputStr = ""
    
    init(threadId: String, threadTitle: String) {
        self.threadId = threadId
        self.threadTitle = threadTitle
        self.commentViewModel = CommentViewModel(threadId: self.threadId)
    }

    var body: some View {
        
        VStack {
            
            // Comments list
            List {
                ForEach(commentViewModel.comments) {comment in
                    VStack(alignment: .leading) {
                        HStack {
                            Text("\(comment.order)")
                            Text(comment.speakerId)
                            Text("\(formatDate(inputDate: comment.createdAt))")
                                .foregroundColor(.secondary)
                        }
                        Text(comment.content)
                            .padding(.top, 2)
                    }
                    .padding(6)
                }
            }
                .listStyle(PlainListStyle())
            
            // New comment content input area
            HStack(alignment: .bottom) {
                TextField("Your comment", text: $inputStr)
                    .submitLabel(.done)
                    .font(.body)
                    .frame(height: 30)
                    .padding(.vertical, 4)
                    .padding(.leading, 16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 19)
                            .stroke(Color.secondary, lineWidth: 1)
                    )
                    .padding(8)
                
                Button(action: {
                    commentViewModel.addComment(content: inputStr)
                    inputStr = ""
                }){
                    Image(systemName: "paperplane.fill")
                        .font(.title3)
                        .padding(.trailing)
                        .padding(.bottom)
                }
                    .disabled(inputStr.isEmpty)
            }
        }
            .navigationBarTitle(threadTitle)
    }
    
    func formatDate(inputDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd E HH:mm:ss"
        return dateFormatter.string(from: inputDate)
    }
    
}
