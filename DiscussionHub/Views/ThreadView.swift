//
//  OpinionsView.swift
//  DiscussionHub
//
//  Created by Yu on 2022/01/27.
//

import SwiftUI

struct ThreadView: View {
    
    let threadId: String
    
    @ObservedObject var threadViewModel: ThreadViewModel
    @ObservedObject var commentViewModel: CommentViewModel
    
    @State var inputStr = ""
    @FocusState var isTextEditorFocused: Bool
    
    init(threadId: String) {
        self.threadId = threadId
        self.threadViewModel = ThreadViewModel(threadId: threadId)
        self.commentViewModel = CommentViewModel(threadId: self.threadId)
    }

    var body: some View {
        
        ZStack(alignment: .bottomLeading) {
            
            // Thraed title and comments list
            List {
                Text(threadViewModel.currentThread!.title)
                    .font(.title)
                    .fontWeight(.bold)
                ForEach(commentViewModel.comments) {comment in
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
                .onTapGesture {
                    isTextEditorFocused = false
                }
                .padding(.bottom, 76)
            
            // Input bar
            HStack(alignment: .center) {
                
                // Input area
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $inputStr)
                        .focused($isTextEditorFocused)
                        .frame(height: 60)
                        .background(Color("TextEditorBackground"))
                        .cornerRadius(10)
                    Text("コメント")
                        .foregroundColor(Color(UIColor.placeholderText))
                        .opacity(inputStr.isEmpty ? 1 : 0)
                        .padding(.top, 8)
                        .padding(.leading, 5)
                }
                    .padding(.leading)
                    .padding(.vertical, 8)
                
                // Send button
                Button(action: {
                    commentViewModel.addComment(content: inputStr)
                    inputStr = ""
                    isTextEditorFocused = false
                }){
                    Image(systemName: "paperplane.fill")
                        .font(.title3)
                }
                    .disabled(inputStr.isEmpty)
                    .padding(.trailing)
                    .padding(.leading, 6)
            }
                .background(Color.secondary.opacity(0.2))
             
        }
        
            .navigationBarTitle("", displayMode: .inline)
    }
    
    func formatDate(inputDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd E HH:mm:ss"
        return dateFormatter.string(from: inputDate)
    }
    
}
