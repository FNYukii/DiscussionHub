//
//  OpinionViewModel.swift
//  DiscussionHub
//
//  Created by Yu on 2022/01/27.
//

import Foundation
import Firebase
import FirebaseAuth
import SwiftUI

class CommentViewModel: ObservableObject {
    
    @Published var allComments: [Comment] = []
    var listener: ListenerRegistration? = nil
    
    func startListeningComments(parentThreadId: String) {
        print("HELLO! Start listening comments")
        let db = Firestore.firestore()
        listener = db.collection("threads")
            .document(parentThreadId)
            .collection("comments")
            .order(by: "createdAt", descending: false)
            .addSnapshotListener {(snapshot, error) in
                guard let snapshot = snapshot else {
                    print("HELLO! Fail! Error fetching snapshots: \(error!)")
                    return
                }
                print("HELLO! Success! Read documents in threads")
                
                // Update allComments array
                snapshot.documentChanges.forEach { diff in
                    if (diff.type == .added) {
                        let id = diff.document.documentID
                        let order = diff.document.get("order") as! Int
                        let content = diff.document.get("content") as! String
                        let authorId = diff.document.get("authorId") as! String
                        let authorDailyId = diff.document.get("authorDailyId") as! String
                        let authorHandleName = diff.document.get("authorHandleName") as! String
                        let createdAt = diff.document.get("createdAt") as! Timestamp
                        let createdDate = createdAt.dateValue()
                        let newComment = Comment(id: id, parentThreadId: parentThreadId, order: order, content: content, authorId: authorId, authorDailyId: authorDailyId, authorHandleName: authorHandleName, createdAt: createdDate)
                        withAnimation {
                            self.allComments.append(newComment)
                        }
                    }
                    if (diff.type == .removed) {
                        let id = diff.document.documentID
                        withAnimation {
                            self.allComments.removeAll(where: {$0.id == id})
                        }
                    }
                }
            }
    }
    
    func stopListeningComments() {
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
                    
                    // Order
                    let commentCount = document.get("commentCount") as! Int
                    let order = commentCount + 1
                    
                    // author id
                    let authorId = Auth.auth().currentUser?.uid ?? ""
                    
                    // author daily id
                    let crypto = Crypto()
                    let authorDailyId = crypto.toCaesarCipher(from: authorId, wordCount: 10)
                    
                    // author handle name
                    var authorHandleName = ""
                    let isUseHandleName = UserDefaults.standard.bool(forKey: "isUseHandleName")
                    if isUseHandleName {
                        authorHandleName = UserDefaults.standard.string(forKey: "handleName") ?? ""
                    }
                    
                    // Add new comment
                    var ref: DocumentReference? = nil
                    ref = db.collection("threads")
                        .document(parentThreadId)
                        .collection("comments")
                        .addDocument(data: [
                            "order": order,
                            "content": content,
                            "authorId": authorId,
                            "authorDailyId": authorDailyId,
                            "authorHandleName": authorHandleName,
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
