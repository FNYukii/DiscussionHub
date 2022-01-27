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
        
        // Get discussion documents
        let db = Firestore.firestore()
        db.collection("discussions")
            .order(by: "createdAt", descending: true)
            .addSnapshotListener {(snapshot, error) in
                if let error = error {
                    print("HELLO Failed to getting documents: \(error)")
                } else {
                    
                    // Create discussions array
                    self.discussions = []
                    for document in snapshot!.documents {
                        let id = document.documentID
                        let title = document.get("title") as! String
                        let createdAt: Timestamp = document.get("createdAt") as! Timestamp
                        let createdDate = createdAt.dateValue()
                        let newDiscusstion = Discussion(id: id, title: title, createdAt: createdDate)
                        self.discussions.append(newDiscusstion)
                    }
                    
                    print("HELLO discussions: \(self.discussions)")
                }
            }
    }
    
    func addDiscussion(title: String) {
        let db = Firestore.firestore()
        db.collection("discussions")
            .addDocument(data: [
                "title": title,
                "createdAt": Date()
            ]) { error in
                if let error = error {
                    print("HELLO Failed to adding new document \(error)")
                } else {
                    print("HELLO Successful adding new document")
                }
            }
    }
    
}
