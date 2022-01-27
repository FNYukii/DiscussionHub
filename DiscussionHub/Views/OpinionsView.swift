//
//  OpinionsView.swift
//  DiscussionHub
//
//  Created by Yu on 2022/01/27.
//

import SwiftUI

struct OpinionsView: View {
    
    let discussionId: String
    let discussionTitle: String
    @ObservedObject var opinionViewModel: OpinionViewModel
    
    @State var inputStr = ""
    
    init(discussionId: String, discussionTitle: String) {
        self.discussionId = discussionId
        self.discussionTitle = discussionTitle
        self.opinionViewModel = OpinionViewModel(discussionId: self.discussionId)
    }

    var body: some View {
        
        VStack {
            
            // Opinions list
            List {
                ForEach(opinionViewModel.opinions) {opinion in
                    VStack(alignment: .leading) {
                        HStack {
                            Text("\(opinion.order)")
                            Text(opinion.speakerId)
                            Text("\(formatDate(inputDate: opinion.createdAt))")
                                .foregroundColor(.secondary)
                        }
                        Text(opinion.content)
                            .padding(.top, 2)
                    }
                    .padding(6)
                }
            }
                .listStyle(PlainListStyle())
            
            // New opinion content input area
            HStack(alignment: .bottom) {
                TextField("メッセージを入力", text: $inputStr)
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
                    opinionViewModel.addOpinion(content: inputStr)
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
            .navigationBarTitle(discussionTitle)
    }
    
    func formatDate(inputDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd E HH:mm:ss"
        return dateFormatter.string(from: inputDate)
    }
    
}
