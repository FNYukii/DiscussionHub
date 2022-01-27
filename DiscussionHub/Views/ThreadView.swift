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
    @ObservedObject var opinionViewModel: OpinionViewModel
    
    @State var inputStr = ""
    
    init(threadId: String, discussionTitle: String) {
        self.threadId = threadId
        self.threadTitle = discussionTitle
        self.opinionViewModel = OpinionViewModel(threadId: self.threadId)
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
                TextField("Your opinion", text: $inputStr)
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
            .navigationBarTitle(threadTitle)
    }
    
    func formatDate(inputDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd E HH:mm:ss"
        return dateFormatter.string(from: inputDate)
    }
    
}
