//
//  discussionViewModel.swift
//  DiscussionHub
//
//  Created by Yu on 2022/01/27.
//

import Foundation
import Firebase

class DiscussionViewModel: ObservableObject {
    
    @Published var discussions: [Discussion] = []
    
    init() {
        let db = Firestore.firestore()
        db.collection("discussions")
            .addSnapshotListener {(snapshot, error) in
                if let error = error {
                    print("hello FAIL getting documents: \(error)")
                } else {
                    self.discussions = []
                    for document in snapshot!.documents {
                        let id = document.documentID
                        let title = document.get("title") as! String
                        let newDiscusstion = Discussion(id: id, title: title)
                        self.discussions.append(newDiscusstion)
                    }
                    print("hello discussions: \(self.discussions)")
                }
            }
    }
    
    func createDiscussion(title: String) {
        let db = Firestore.firestore()
        db.collection("discussions")
            .addDocument(data: [
                "title": title
            ]) { error in
                if let error = error {
                    print("hello FAIL adding document \(error)")
                } else {
                    print("hello SUCCESS added new document")
                }
            }
    }
    
}
