//
//  Opinion.swift
//  DiscussionHub
//
//  Created by Yu on 2022/01/27.
//

import Foundation

struct Comment: Identifiable, Hashable {
    var id: String
    var parentThreadId: String
    var order: Int
    var content :String
    var authorId: String
    var authorDailyId: String
    var authorDisplayName: String
    var createdAt: Date
}
