//
//  discussionViewModel.swift
//  DiscussionHub
//
//  Created by Yu on 2022/01/27.
//

import Foundation
import Firebase
import FirebaseAuth
import SwiftUI

class ThreadViewModel: ObservableObject {
    
    @Published var allThreads: [Thread] = []
    var listener: ListenerRegistration? = nil
    
    func startListeningThreads() {
        print("HELLO! Start listening threads")
        let db = Firestore.firestore()
        listener = db.collection("threads")
            .order(by: "createdAt", descending: true)
            .addSnapshotListener {(snapshot, error) in
                guard let snapshot = snapshot else {
                    print("HELLO! Fail! Error fetching snapshots: \(error!)")
                    return
                }
                print("HELLO! Success! Read documents in threads")
                
                // Update allThreads array
                snapshot.documentChanges.forEach { diff in
                    if (diff.type == .added) {
                        let id = diff.document.documentID
                        let title = diff.document.get("title") as! String
                        let authorId = diff.document.get("authorId") as! String
                        let authorDisplayname = diff.document.get("authorDisplayname") as! String
                        let createdAt: Timestamp = diff.document.get("createdAt") as! Timestamp
                        let createdDate = createdAt.dateValue()
                        let commentCount = diff.document.get("commentCount") as! Int
                        let newThread = Thread(id: id, title: title, authorId: authorId, authorDisplayname: authorDisplayname, createdAt: createdDate, commentCount: commentCount)
                        withAnimation {
                            self.allThreads.append(newThread)
                        }
                    }
                    if (diff.type == .removed) {
                        let id = diff.document.documentID
                        withAnimation {
                            self.allThreads.removeAll(where: {$0.id == id})
                        }
                    }
                }
            }
    }
    
    func stopListeningThreads() {
        print("HELLO! Stop listening threads")
        listener?.remove()
    }
    
    func addThread(title: String, firstCommentContent: String) {
        // User id
        let userId = Auth.auth().currentUser?.uid ?? ""
        
        // User displayname
        let crypto = Crypto()
        let userDisplayname = crypto.toCaesarCipher(from: userId, wordCount: 10)
        
        // Add new thread
        let db = Firestore.firestore()
        var ref: DocumentReference? = nil
        ref = db.collection("threads")
            .addDocument(data: [
                "title": title,
                "authorId": userId,
                "authorDisplayname": userDisplayname,
                "createdAt": Date(),
                "commentCount": 0
            ]) { error in
                if let error = error {
                    print("HELLO! Fail! Error adding new document: \(error)")
                } else {
                    print("HELLO! Success! Added new document \(ref!.documentID) to threads")
                    
                    // Add first comment in this thread
                    let commentViewModel = CommentViewModel()
                    commentViewModel.addComment(parentThreadId: ref!.documentID, content: firstCommentContent)
                }
            }
    }
    
    func deleteThread(threadId: String) {
        let db = Firestore.firestore()
        db.collection("threads")
            .document(threadId)
            .delete() { err in
                if let err = err {
                    print("HELLO! Fail! Error removing document: \(err)")
                } else {
                    print("HELLO! Success! Removed document \(threadId) from threads")
                }
            }
    }
    
    func incrementCommentCount(threadId: String) {
        // Get thread
        let db = Firestore.firestore()
        db.collection("threads")
            .document(threadId)
            .getDocument { (document, error) in
                if let document = document, document.exists {
                    print("HELLO! Success! Read document \(threadId) from threads")
                    
                    // Increment comment counter
                    let commentCount = document.get("commentCount") as! Int
                    let newCommentCount = commentCount + 1
                    db.collection("threads")
                        .document(threadId)
                        .updateData([
                            "commentCount": newCommentCount
                        ]) { err in
                            if let err = err {
                                print("HELLO! Fail! Error updating document: \(err)")
                            } else {
                                print("HELLO! Success! Updated document \(threadId) in threads")
                            }
                        }
                } else {
                    print("HELLO! Fail! Document does not exist")
                }
            }
    }
    
}
