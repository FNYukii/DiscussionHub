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
    @State var isShowScrollButton = true
    
    init(thread: Thread) {
        self.showingThread = thread
        self.commentViewModel = CommentViewModel()
        self.commentViewModel.readComments(parentThreadId: thread.id)
    }
    
    var body: some View {
        
        ScrollViewReader {proxy in
            
            ZStack(alignment: .bottom) {
                
                List {
                    Text(showingThread.title)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    AllCommentForeach(showingThread: showingThread, allComments: commentViewModel.allComments)
                    
                    Color.clear
                        .frame(height: 1, alignment: .bottom)
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                        .onAppear {
                            isShowScrollButton = false
                            print("HELLO! Appeared")
                        }
                        .onDisappear {
                            print("HELL0! Disappeared")
                        }
                }
                .listStyle(PlainListStyle())
                .environment(\.defaultMinListRowHeight, 0)
                .onTapGesture {
                    isTextEditorFocused = false
                }
                .padding(.bottom, 76)

                CreateCommentBar(parentThreadId: showingThread.id, isTextEditorFocused: $isTextEditorFocused)
                
                // Scroll button
                Button(action: {
                    withAnimation {
                        proxy.scrollTo(commentViewModel.allComments[commentViewModel.allComments.endIndex - 1])
                    }
                    isShowScrollButton = false
                }){
                    Label("新着コメント", systemImage: "arrow.down")
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.accentColor)
                        .cornerRadius(16)
                }
                .padding(.bottom, 90.0)
                .padding(.leading)
                .opacity(isShowScrollButton ? 1 : 0)
                
            }
            
            // If comments changed, enable scroll button
            .onChange(of: commentViewModel.allComments) {_ in
                isShowScrollButton = true
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
