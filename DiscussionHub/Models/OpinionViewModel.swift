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
    
    init() {
        let db = Firestore.firestore()
        db.collection("discussions")
            .document("fhaghladkj")
            .collection("opinions")
            .order(by: "createdAt", descending: true)
            .addSnapshotListener {(snapshot, error) in
                if let error = error {
                    print("hello Fail getting documents: \(error)")
                } else {
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
                    print("hello discussions: \(self.opinions)")
                }
            }
    }
}
