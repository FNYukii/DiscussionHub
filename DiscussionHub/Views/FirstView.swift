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
    @State var isShowSheet = false
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(discussionViewModel.discussions, id: \.id) {discussion in
                    NavigationLink(destination: OpinionsView(discussionId: discussion.id, discussionTitle: discussion.title)) {
                        Text(discussion.title)
                    }
                }
            }
            .sheet(isPresented: $isShowSheet) {
                CreateDiscussionView()
            }
            .navigationBarTitle("Discussions")
            .navigationBarItems(
                trailing: Button(action: {
                    isShowSheet.toggle()
                }){
                    Image(systemName: "plus.circle.fill")
                    Text("New discussion")
                }
            )
        }
        
    }
}
