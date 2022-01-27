//
//  CreateDiscussionView.swift
//  DiscussionHub
//
//  Created by Yu on 2022/01/27.
//

import SwiftUI

struct CreateDiscussionView: View {
    
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
                .navigationBarTitle("New Discussion", displayMode: .inline)
                .navigationBarItems(leading:
                    Button("Cancel"){
                        dismiss()
                    }, trailing:
                    Button(action: {
                        let discussionViewModel = DiscussionViewModel()
                        discussionViewModel.addDiscussion(title: title)
                        dismiss()
                    }){
                        Text("Create")
                            .fontWeight(.bold)
                    }
                )
        }
    }
}
