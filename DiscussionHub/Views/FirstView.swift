//
//  FirstView.swift
//  DiscussionHub
//
//  Created by Yu on 2022/01/27.
//

import SwiftUI
import Firebase

struct FirstView: View {
    
    @ObservedObject var discussionViewModel = DiscussionViewModel()
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(discussionViewModel.discussions, id: \.id) {discussion in
                    Text(discussion.title)
                }
            }
            .navigationBarTitle("Discussions")
        }
        
    }
}
