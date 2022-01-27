//
//  discussionViewModel.swift
//  DiscussionHub
//
//  Created by Yu on 2022/01/27.
//

import Foundation
import Firebase

class ThreadViewModel: ObservableObject {
    
    @Published var threads: [Thread] = []
    
    init() {
        
        // Get thread documents
        let db = Firestore.firestore()
        db.collection("threads")
            .order(by: "createdAt", descending: true)
            .addSnapshotListener {(snapshot, error) in
                if let error = error {
                    print("HELLO Failed to getting documents: \(error)")
                } else {
                    
                    // Create threads array
                    self.threads = []
                    for document in snapshot!.documents {
                        let id = document.documentID
                        let title = document.get("title") as! String
                        let createdAt: Timestamp = document.get("createdAt") as! Timestamp
                        let createdDate = createdAt.dateValue()
                        let newDiscusstion = Thread(id: id, title: title, createdAt: createdDate)
                        self.threads.append(newDiscusstion)
                    }
                    
                    print("HELLO threads: \(self.threads)")
                }
            }
    }
    
    func addDiscussion(title: String, firstOpinionContent: String) {
        let db = Firestore.firestore()
        var ref: DocumentReference? = nil
        ref = db.collection("threads")
            .addDocument(data: [
                "title": title,
                "createdAt": Date()
            ]) { error in
                if let error = error {
                    print("HELLO Failed to adding new document \(error)")
                } else {
                    print("HELLO Successful adding new document \(ref!.documentID)")
                    
                    // Add first opinion in this thread
                    let opinionViewModel = OpinionViewModel(threadId: ref!.documentID)
                    opinionViewModel.addOpinion(content: firstOpinionContent)
                }
            }
    }
    
}
