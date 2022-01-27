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
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Discussion title", text: $title)
                    .submitLabel(.done)
            }
                .navigationBarTitle("New Discussion", displayMode: .inline)
                .navigationBarItems(leading:
                    Button("Cancel"){
                        dismiss()
                    }, trailing:
                    Button(action: {
                        dismiss()
                    }){
                        Text("Create")
                            .fontWeight(.bold)
                    }
                )
        }
    }
}
