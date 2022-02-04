//
//  Opinion.swift
//  DiscussionHub
//
//  Created by Yu on 2022/01/27.
//

import Foundation

struct Comment: Identifiable, Hashable {
    let id: String
    let parentThreadId: String
    let order: Int
    let content :String
    let authorId: String
    let authorDailyId: String
    let authorHandleName: String
    let createdAt: Date
}
