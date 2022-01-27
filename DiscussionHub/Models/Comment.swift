//
//  Opinion.swift
//  DiscussionHub
//
//  Created by Yu on 2022/01/27.
//

import Foundation

struct Comment: Identifiable {
    var id: String
    var order: Int
    var content :String
    var userId: String
    var createdAt: Date
}
