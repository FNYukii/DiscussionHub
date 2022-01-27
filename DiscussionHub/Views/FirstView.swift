//
//  FirstView.swift
//  DiscussionHub
//
//  Created by Yu on 2022/01/27.
//

import SwiftUI
import Firebase

struct FirstView: View {
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear(perform: load)
    }
        
    func load() {
        
        // Get all descussion document
        let db = Firestore.firestore()
        let docRef = db.collection("discussions")
        docRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("hello Fail getting document: \(error)")
            } else {
                for document in querySnapshot!.documents {
                    print("hello \(document.documentID) : \(document.data())")
                }
            }
        }
    }
}
