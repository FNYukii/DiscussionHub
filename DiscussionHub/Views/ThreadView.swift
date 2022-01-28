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
    
    @FocusState var isTextEditorFocused: Bool
    
    init(threadId: String) {
        self.threadId = threadId
        self.threadViewModel = ThreadViewModel(threadId: threadId)
        self.commentViewModel = CommentViewModel(threadId: self.threadId)
    }
    
    var body: some View {
        
        ScrollViewReader {proxy in
            
            ZStack(alignment: .bottomLeading) {
                
                TitleAndCommentList(threadViewModel: threadViewModel, commentViewModel: commentViewModel)
                    .onTapGesture {
                        isTextEditorFocused = false
                    }
                    .padding(.bottom, 76)
                
                CreateCommentBar(commentViewModel: commentViewModel, isTextEditorFocused: $isTextEditorFocused)
            }
            
            // If comments changed, Scroll list to end
            .onChange(of: commentViewModel.comments) {_ in
                withAnimation {
                    proxy.scrollTo(commentViewModel.comments[commentViewModel.comments.endIndex - 1])
                }
            }
            
            // When TextEditor focused, Scroll list to end
            .onChange(of: isTextEditorFocused) {value in
                if value {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                        withAnimation {
                            proxy.scrollTo(commentViewModel.comments[commentViewModel.comments.endIndex - 1])
                        }
                    }
                }
            }
            
        }
        .navigationBarTitle("", displayMode: .inline)
    }
    
    func formatDate(inputDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd E HH:mm:ss"
        return dateFormatter.string(from: inputDate)
    }
    
}
