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
    @Published var currentThread: Thread? = nil
    
    init(threadId: String = "") {
        
        // If threadId exists, get thread title
        if !threadId.isEmpty {
            let db = Firestore.firestore()
            db.collection("threads")
                .document(threadId)
                .addSnapshotListener { documentSnapshot, error in
                    guard let document = documentSnapshot else {
                        print("Error fetching document: \(error!)")
                        return
                    }
                    let title = document.get("title") as! String
                    let authorId = document.get("authorId") as! String
                    let createdAt = document.get("createdAt") as! Timestamp
                    let createdDate = createdAt.dateValue()
                    self.currentThread = Thread(id: threadId, title: title, authorId: authorId, createdAt: createdDate)
                }
        }
        
        // Get all threads
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
                        let authorId = document.get("authorId") as! String
                        let createdAt: Timestamp = document.get("createdAt") as! Timestamp
                        let createdDate = createdAt.dateValue()
                        let newThread = Thread(id: id, title: title, authorId: authorId, createdAt: createdDate)
                        self.threads.append(newThread)
                    }
                    
                    print("HELLO threads: \(self.threads)")
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
                    print("HELLO Failed to adding new document \(error)")
                } else {
                    print("HELLO Successful adding new document \(ref!.documentID)")
                    
                    // Add first opinion in this thread
                    let commentViewModel = CommentViewModel(threadId: ref!.documentID)
                    commentViewModel.addComment(content: firstCommentContent)
                }
            }
    }
    
    func deleteThread(threadId: String) {
        // Get thread
        let db = Firestore.firestore()
        db.collection("threads")
            .document(threadId)
            .getDocument { (document, error) in
                if let document = document, document.exists {
                    // Check authorId and userId
                    let authorId = document.get("authorId") as! String
                    let userId = UserDefaults.standard.string(forKey: "userId")
                    // Delete thread
                    if authorId == userId {
                        db.collection("threads")
                            .document(threadId)
                            .delete() { err in
                                if let err = err {
                                    print("HELLO Error removing document: \(err)")
                                } else {
                                    print("HELLO Document successfully removed!")
                                }
                            }
                    }
                } else {
                    print("HELLO Document does not exist")
                }
            }
    }
    
}
