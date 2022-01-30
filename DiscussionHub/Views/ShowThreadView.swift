//
//  OpinionsView.swift
//  DiscussionHub
//
//  Created by Yu on 2022/01/27.
//

import SwiftUI

struct ShowThreadView: View {
    
    let threadId: String
    
    @ObservedObject var threadViewModel: ThreadViewModel
    @ObservedObject var commentViewModel: CommentViewModel
    
    let userId = UserDefaults.standard.string(forKey: "userId")
    @FocusState var isTextEditorFocused: Bool
    @State var isShowDeleteThreadConfirmation = false
    
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
                    var second = 0.00
                    Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) {timer in
                        second += 0.01
                        if second > 0.4 {
                            timer.invalidate()
                        }
                        proxy.scrollTo(commentViewModel.comments[commentViewModel.comments.endIndex - 1])
                    }
                }
            }
        }
        
        .confirmationDialog("", isPresented: $isShowDeleteThreadConfirmation, titleVisibility: .hidden) {
            Button("スレッドを削除", role: .destructive) {
                threadViewModel.deleteThread(threadId: threadViewModel.currentThread!.id)
            }
        } message: {
            Text("このスレッドを削除してもよろしいですか?").bold()
        }
        
        .navigationBarTitle("", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button(action: {
                        // TODO: Bookmark comment
                    }){
                        Label("スレッドをブックマークに追加", systemImage: "bookmark")
                    }
                    if threadViewModel.currentThread?.authorId == userId {
                        Button(role: .destructive) {
                            isShowDeleteThreadConfirmation.toggle()
                        } label: {
                            Label("スレッドを削除", systemImage: "trash")
                        }
                    } else {
                        Button(action: {
                            // TODO: Report thread
                        }){
                            Label("スレッドを報告する", systemImage: "flag")
                        }
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
        }
    }
    
    func formatDate(inputDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd E HH:mm:ss"
        return dateFormatter.string(from: inputDate)
    }
    
}
