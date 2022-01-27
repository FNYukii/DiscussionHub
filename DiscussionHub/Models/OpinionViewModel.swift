//
//  OpinionViewModel.swift
//  DiscussionHub
//
//  Created by Yu on 2022/01/27.
//

import Foundation
import Firebase

class OpinionViewModel: ObservableObject {
    
    @Published var opinions: [Opinion] = []
    var discussionId = ""
    
    init(discussionId: String) {
        // Set discussionId
        self.discussionId = discussionId
        
        // Get opinion documents
        let db = Firestore.firestore()
        db.collection("discussions")
            .document(self.discussionId)
            .collection("opinions")
            .order(by: "createdAt", descending: false)
            .addSnapshotListener {(snapshot, error) in
                
                if let error = error {
                    print("HELLO Failed to getting documents: \(error)")
                } else {
                    
                    // Create opinions array
                    self.opinions = []
                    for document in snapshot!.documents {
                        let id = document.documentID
                        let order = document.get("order") as! Int
                        let content = document.get("content") as! String
                        let speakerId = document.get("speakerId") as! String
                        let createdAt = document.get("createdAt") as! Timestamp
                        let createdDate = createdAt.dateValue()
                        let newOpinion = Opinion(id: id, order: order, content: content, speakerId: speakerId, createdAt: createdDate)
                        self.opinions.append(newOpinion)
                    }
                    
                    print("HELLO opinions: \(self.opinions)")
                }
            }
    }
    
    func addOpinion(content: String) {
        // Create order and speakerId value
        let order = opinions.count + 1
        let speakerId = "fadfljkj"
        
        // Add new opinion
        let db = Firestore.firestore()
        db.collection("discussions")
            .document(discussionId)
            .collection("opinions")
            .addDocument(data: [
                "order": order,
                "content": content,
                "speakerId": speakerId,
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
