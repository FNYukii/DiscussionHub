//
//  CreateDiscussionView.swift
//  DiscussionHub
//
//  Created by Yu on 2022/01/27.
//

import SwiftUI

struct CreateThreadView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var title = ""
    @State var firstCommentContent = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("タイトル", text: $title)
                    .submitLabel(.done)
                TextField("コメント", text: $firstCommentContent)
                    .submitLabel(.done)
            }
            .navigationBarTitle("新規スレッド", displayMode: .inline)
            .navigationBarItems(
                leading: Button("キャンセル"){
                    dismiss()
                },
                trailing:  Button(action: {
                    let threadViewModel = ThreadViewModel()
                    threadViewModel.addThread(title: title, firstCommentContent: firstCommentContent)
                    dismiss()
                }){
                    Text("作成")
                        .fontWeight(.bold)
                }
                    .disabled(title.isEmpty || firstCommentContent.isEmpty)
            )
        }
    }
}
