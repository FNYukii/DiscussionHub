//
//  OpinionsView.swift
//  DiscussionHub
//
//  Created by Yu on 2022/01/27.
//

import SwiftUI

struct ShowThreadView: View {
    
    let showingThread: Thread
    @ObservedObject var commentViewModel: CommentViewModel
    
    @FocusState var isTextEditorFocused: Bool
    
    init(thread: Thread) {
        self.showingThread = thread
        self.commentViewModel = CommentViewModel()
        self.commentViewModel.readComments(parentThreadId: thread.id)
    }
    
    var body: some View {
        
        ScrollViewReader {proxy in
            
            ZStack(alignment: .bottomLeading) {
                TitleAndCommentList(showingThread: showingThread, allComments: commentViewModel.allComments)
                    .onTapGesture {
                        isTextEditorFocused = false
                    }
                    .padding(.bottom, 76)
                CreateCommentBar(parentThreadId: showingThread.id, isTextEditorFocused: $isTextEditorFocused)
            }
            
            // If comments changed, Scroll list to end
            .onChange(of: commentViewModel.allComments) {_ in
                withAnimation {
                    proxy.scrollTo(commentViewModel.allComments[commentViewModel.allComments.endIndex - 1])
                }
            }
            
            // When keyboard appeared, Scroll list to end
            .onChange(of: isTextEditorFocused) {value in
                if value {
                    var second = 0.00
                    Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) {timer in
                        second += 0.01
                        if second > 0.4 {
                            timer.invalidate()
                        }
                        proxy.scrollTo(commentViewModel.allComments[commentViewModel.allComments.endIndex - 1])
                    }
                }
            }
        }
        
        .navigationBarTitle("", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                ThreadMenu(showingThread: showingThread)
            }
        }
    }
    
    func formatDate(inputDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd E HH:mm:ss"
        return dateFormatter.string(from: inputDate)
    }
    
}
