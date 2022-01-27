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
    
    init(discussionId: String, discussionTitle: String) {
        self.discussionId = discussionId
        self.discussionTitle = discussionTitle
        self.opinionViewModel = OpinionViewModel(discussionId: self.discussionId)
    }

    var body: some View {
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
            .navigationBarTitle(discussionTitle)
            .navigationBarItems(trailing: Button("plus") {
                    opinionViewModel.addOpinion(content: "I think so too")
            })
    }
    
    func formatDate(inputDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd E HH:mm:ss"
        return dateFormatter.string(from: inputDate)
    }
    
}
