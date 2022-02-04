//
//  discussion.swift
//  DiscussionHub
//
//  Created by Yu on 2022/01/27.
//

import Foundation

struct Thread: Identifiable {
    let id: String
    let title: String
    let authorId: String
    let createdAt: Date
    let commentCount: Int
}
