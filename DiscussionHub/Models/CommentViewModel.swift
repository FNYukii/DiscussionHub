//
//  OpinionViewModel.swift
//  DiscussionHub
//
//  Created by Yu on 2022/01/27.
//

import Foundation
import Firebase

class CommentViewModel: ObservableObject {
    
    @Published var allComments: [Comment] = []
    var listener: ListenerRegistration? = nil
    
    func startListenComments(parentThreadId: String) {
        print("HELLO! Start listening comments")
        let db = Firestore.firestore()
        listener = db.collection("threads")
            .document(parentThreadId)
            .collection("comments")
            .order(by: "createdAt", descending: false)
            .addSnapshotListener {(snapshot, error) in
                if let error = error {
                    print("HELLO! Fail! Error getting documents: \(error)")
                } else {
                    print("HELLO! Success! Read comments in thread \(parentThreadId) ")
                    
                    // Create comments array
                    self.allComments = []
                    for document in snapshot!.documents {
                        let id = document.documentID
                        let order = document.get("order") as! Int
                        let content = document.get("content") as! String
                        let authorId = document.get("authorId") as! String
                        let createdAt = document.get("createdAt") as! Timestamp
                        let createdDate = createdAt.dateValue()
                        let newComment = Comment(id: id, order: order, content: content, authorId: authorId, createdAt: createdDate)
                        self.allComments.append(newComment)
                    }
                }
            }
    }
    
    func stopListenComments() {
        print("HELLO! Stop listening comments")
        listener?.remove()
    }
    
    func addComment(parentThreadId: String, content: String) {
        // Get parent thread commentCount
        let db = Firestore.firestore()
        db.collection("threads")
            .document(parentThreadId)
            .getDocument { (document, error) in
                if let document = document, document.exists {
                    print("HELLO! Success! Read document \(parentThreadId) from threads")
                    let commentCount = document.get("commentCount") as! Int
                    
                    // Add new comment
                    let order = commentCount + 1
                    let userId = UserDefaults.standard.string(forKey: "userId")!
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
                                
                                // Increment commentCount in parent thread
                                let threadViewModel = ThreadViewModel()
                                threadViewModel.incrementCommentCount(threadId: parentThreadId)
                            }
                        }
                    
                } else {
                    print("HELLO! Fail! Document does not exist")
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
