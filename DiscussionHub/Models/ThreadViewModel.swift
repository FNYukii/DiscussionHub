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
    
    func readThreads() {
        let db = Firestore.firestore()
        db.collection("threads")
            .order(by: "createdAt", descending: true)
            .addSnapshotListener {(snapshot, error) in
                if let error = error {
                    print("HELLO! Fail! Error geting documents: \(error)")
                } else {
                    print("HELLO! Success! Read threads")
                    
                    // Create threads array
                    self.threads = []
                    for document in snapshot!.documents {
                        let id = document.documentID
                        let title = document.get("title") as! String
                        let authorId = document.get("authorId") as! String
                        let createdAt: Timestamp = document.get("createdAt") as! Timestamp
                        let createdDate = createdAt.dateValue()
                        let newThread = Thread(id: id, title: title, authorId: authorId, createdAt: createdDate)
                        self.threads.append(newThread)
                    }
                }
            }
    }
        
    func addThread(title: String, firstCommentContent: String) {
        let userId = UserDefaults.standard.string(forKey: "userId")!
        let db = Firestore.firestore()
        var ref: DocumentReference? = nil
        ref = db.collection("threads")
            .addDocument(data: [
                "title": title,
                "authorId": userId,
                "createdAt": Date()
            ]) { error in
                if let error = error {
                    print("HELLO! Fail! Error adding new document: \(error)")
                } else {
                    print("HELLO! Success! Added new document \(ref!.documentID) to threads")
                    
                    // Add first comment in this thread
                    let commentViewModel = CommentViewModel()
                    commentViewModel.addComment(threadId: ref!.documentID, content: firstCommentContent)
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
    
    func updateThread(threadId: String, threadTitle: String) {
        let db = Firestore.firestore()
        db.collection("threads")
            .document(threadId)
            .updateData([
                "title": threadTitle
            ]) { err in
                if let err = err {
                    print("HELLO! Fail! Error updating document: \(err)")
                } else {
                    print("HELLO! Success! Updated document \(threadId) in threads")
                }
            }
    }
    
}
