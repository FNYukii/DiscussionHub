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
    @FocusState var isTextFieldFocused: Bool
    
    init(threadId: String, threadTitle: String) {
        self.threadId = threadId
        self.threadTitle = threadTitle
        self.commentViewModel = CommentViewModel(threadId: self.threadId)
    }

    var body: some View {
        
        VStack {
            
            // Comments list
            List {
                Text(threadTitle)
                    .font(.title)
                    .fontWeight(.bold)
                ForEach(commentViewModel.comments) {comment in
                    VStack(alignment: .leading) {
                        Divider()
                        HStack {
                            Text("\(comment.order)")
                            Text(comment.userId)
                            Text("\(formatDate(inputDate: comment.createdAt))")
                                .foregroundColor(.secondary)
                        }
                        .padding(.horizontal, 12)
                        Text(comment.content)
                            .padding(.top, 2)
                            .padding(.horizontal, 12)
                    }
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                    .padding(6)
                }
            }
                .listStyle(PlainListStyle())
            
            // New comment content input area
            HStack(alignment: .bottom) {
                TextField("Your comment", text: $inputStr)
                    .focused($isTextFieldFocused)
                    .submitLabel(.done)
                    .frame(height: 30)
                    .padding(.vertical, 4)
                    .padding(.leading, 16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 19)
                            .stroke(Color.secondary.opacity(0.8), lineWidth: 0.8)
                    )
                    .padding(.vertical, 8)
                    .padding(.leading, 16)
                
                Button(action: {
                    commentViewModel.addComment(content: inputStr)
                    inputStr = ""
                    isTextFieldFocused = false
                }){
                    Image(systemName: "paperplane.fill")
                        .font(.title3)
                        .padding(.trailing)
                        .padding(.bottom)
                }
                    .disabled(inputStr.isEmpty)
            }
        }
            .navigationBarTitle("Thread detail", displayMode: .inline)
    }
    
    func formatDate(inputDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd E HH:mm:ss"
        return dateFormatter.string(from: inputDate)
    }
    
}
