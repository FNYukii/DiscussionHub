//
//  CreateDiscussionView.swift
//  DiscussionHub
//
//  Created by Yu on 2022/01/27.
//

import SwiftUI

struct CreateDiscussionView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Text("hello")
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
