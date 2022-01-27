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

    var body: some View {
        List {
            VStack(alignment: .leading) {
                HStack {
                    Text("1")
                    Text("fkajlglkk")
                    Text("2022-01-27")
                        .foregroundColor(.secondary)
                }
                Text("How do you think?")
                    .padding(.top, 2)
            }
            .padding(6)
        }
        .listStyle(PlainListStyle())
            .navigationBarTitle(discussionTitle)
    }
}
