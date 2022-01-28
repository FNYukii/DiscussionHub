//
//  EditCommentView.swift
//  DiscussionHub
//
//  Created by Yu on 2022/01/29.
//

import SwiftUI

struct EditCommentView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var content = ""
    
    var body: some View {
        
        NavigationView {
            Form {
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $content)
                    Text("コメント")
                        .foregroundColor(Color(UIColor.placeholderText))
                        .opacity(content.isEmpty ? 1 : 0)
                        .padding(.top, 8)
                        .padding(.leading, 5)
                }
                
                Section {
                    Button("コメントを削除") {
                        // TODO: Delete comment
                    }
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, alignment: .center)
                }
               
            }
            .navigationBarTitle("コメントを編集", displayMode: .inline)
            .navigationBarItems(
                leading: Button("キャンセル"){
                    dismiss()
                },
                trailing:  Button(action: {
                    dismiss()
                }){
                    Text("完了")
                        .fontWeight(.bold)
                }
                    .disabled(content.isEmpty)
            )
        }
    }
}
