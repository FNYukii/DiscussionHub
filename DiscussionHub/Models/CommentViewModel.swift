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
    
    func readComments(parentThreadId: String) {
        let db = Firestore.firestore()
        db.collection("threads")
            .document(parentThreadId)
            .collection("comments")
            .order(by: "createdAt", descending: false)
            .addSnapshotListener {(snapshot, error) in
                
                if let error = error {
                    print("HELLO! Fail! Error getting documents: \(error)")
                } else {
                    print("HELLO! Success! Read comments in thread \(parentThreadId) ")
                    
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
    
    func addComment(parentThreadId: String, content: String) {
        // TODO: Get parent thread commentCount
        let order = 1
        let userId = UserDefaults.standard.string(forKey: "userId")!
        
        // Add new comment
        let db = Firestore.firestore()
        var ref: DocumentReference? = nil
        ref = db.collection("threads")
            .document(parentThreadId)
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
                    // TODO: Increment commentCount in parent thread
                }
            }
    }
    
    func deleteComment(parentThreadId: String, commentId: String) {
        let db = Firestore.firestore()
        db.collection("threads")
            .document(parentThreadId)
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
    
}
