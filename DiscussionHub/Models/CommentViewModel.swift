//
//  OpinionViewModel.swift
//  DiscussionHub
//
//  Created by Yu on 2022/01/27.
//

import Foundation
import Firebase

class CommentViewModel: ObservableObject {
    
    @Published var comments: [Comment] = []
    var threadId = ""
    
    init(threadId: String) {
        // Set threadId
        self.threadId = threadId
        
        // Get comment documents
        let db = Firestore.firestore()
        db.collection("threads")
            .document(self.threadId)
            .collection("comments")
            .order(by: "createdAt", descending: false)
            .addSnapshotListener {(snapshot, error) in
                
                if let error = error {
                    print("HELLO Failed to getting documents: \(error)")
                } else {
                    
                    // Create comments array
                    self.comments = []
                    for document in snapshot!.documents {
                        let id = document.documentID
                        let order = document.get("order") as! Int
                        let content = document.get("content") as! String
                        let speakerId = document.get("speakerId") as! String
                        let createdAt = document.get("createdAt") as! Timestamp
                        let createdDate = createdAt.dateValue()
                        let newComment = Comment(id: id, order: order, content: content, speakerId: speakerId, createdAt: createdDate)
                        self.comments.append(newComment)
                    }
                    
                    print("HELLO comments: \(self.comments)")
                }
            }
    }
    
    func addComment(content: String) {
        // Create order and speakerId value
        let latestCommentOrder = comments.last?.order ?? 0
        let order = latestCommentOrder + 1
        let speakerId = "fadfljkj"
        
        // Add new comment
        let db = Firestore.firestore()
        db.collection("threads")
            .document(threadId)
            .collection("comments")
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
