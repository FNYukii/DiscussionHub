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
    
    init(threadId: String = "") {
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
                    print("HELLO! Fail! Error getting documents: \(error)")
                } else {
                    print("HELLO! Success! Read comments in thread \(self.threadId) ")
                    
                    // Create comments array
                    self.comments = []
                    for document in snapshot!.documents {
                        let id = document.documentID
                        let order = document.get("order") as! Int
                        let content = document.get("content") as! String
                        let authorId = document.get("authorId") as! String
                        let createdAt = document.get("createdAt") as! Timestamp
                        let createdDate = createdAt.dateValue()
                        let newComment = Comment(id: id, order: order, content: content, authorId: authorId, createdAt: createdDate)
                        self.comments.append(newComment)
                    }
                }
            }
    }
    
    func addComment(content: String) {
        // Create order and speakerId value
        let latestCommentOrder = comments.last?.order ?? 0
        let order = latestCommentOrder + 1
        let userId = UserDefaults.standard.string(forKey: "userId")!
        
        // Add new comment
        let db = Firestore.firestore()
        var ref: DocumentReference? = nil
        ref = db.collection("threads")
            .document(threadId)
            .collection("comments")
            .addDocument(data: [
                "order": order,
                "content": content,
                "authorId": userId,
                "createdAt": Date()
            ]) { error in
                if let error = error {
                    print("HELLO! Fail! Error adding new document \(error)")
                } else {
                    print("HELLO! Success! Added new document \(ref!.documentID) to comments")
                }
            }
    }
    
    func deleteComment(threadId: String, commentId: String) {
        let db = Firestore.firestore()
        db.collection("threads")
            .document(threadId)
            .collection("comments")
            .document(commentId)
            .delete() { err in
                if let err = err {
                    print("HELLO! Fail! Error removing document: \(err)")
                } else {
                    print("HELLO! Success! Removed document \(commentId) from comments")
                }
            }
    }
    
    func updateComment(threadId: String, commentId: String, commentContent: String) {
        let db = Firestore.firestore()
        db.collection("threads")
            .document(threadId)
            .collection("comments")
            .document(commentId)
            .updateData([
                "content": commentContent
            ]) { err in
                if let err = err {
                    print("HELLO! Fail! Error updating document: \(err)")
                } else {
                    print("HELLO! Success! Updated document \(commentId) in comments")
                }
            }
    }
}
