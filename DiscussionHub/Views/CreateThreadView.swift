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
    @State var firstOpinionContent = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                    .submitLabel(.done)
                TextField("Description", text: $firstOpinionContent)
                    .submitLabel(.done)
            }
                .navigationBarTitle("New Thread", displayMode: .inline)
                .navigationBarItems(leading:
                    Button("Cancel"){
                        dismiss()
                    }, trailing:
                    Button(action: {
                        let discussionViewModel = ThreadViewModel()
                        discussionViewModel.addDiscussion(title: title, firstOpinionContent: firstOpinionContent)
                        dismiss()
                    }){
                        Text("Create")
                            .fontWeight(.bold)
                    }
                )
        }
    }
}
