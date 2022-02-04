//
//  OpinionsView.swift
//  DiscussionHub
//
//  Created by Yu on 2022/01/27.
//

import SwiftUI

struct ShowThreadView: View {
    
    let showingThread: Thread
    @ObservedObject var commentViewModel = CommentViewModel()
    
    @FocusState var isTextEditorFocused: Bool
    @State var isScrolledToEnd = false
    @State var isShowScrollButton = true
    
    init(showingThread: Thread) {
        self.showingThread = showingThread
        commentViewModel.startListeningComments(parentThreadId: showingThread.id)
    }
    
    var body: some View {
        
        ScrollViewReader {proxy in
            
            ZStack(alignment: .bottom) {
                
                List {
                    Text(showingThread.title)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    ForEach(commentViewModel.allComments, id: \.self) {comment in
                        OneCommentRow(showingComment: comment)
                    }
                    
                    Color.clear
                        .frame(height: 1, alignment: .bottom)
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                        .onAppear {
                            print("HELLO! List bottom appeared")
                            isShowScrollButton = false
                            isScrolledToEnd = true
                        }
                        .onDisappear {
                            print("HELLO! List bottom disappeared")
                            isScrolledToEnd = false
                        }
                        .id(9999)
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
                        proxy.scrollTo(9999)
                    }
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
            
            // If comments changed, scroll to end or show scroll button
            .onChange(of: commentViewModel.allComments) {_ in
                if isScrolledToEnd {
                    withAnimation {
                        proxy.scrollTo(9999)
                    }
                } else {
                    isShowScrollButton = true
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
                        proxy.scrollTo(9999)
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
    
}
