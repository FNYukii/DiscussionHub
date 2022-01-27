//
//  Opinion.swift
//  DiscussionHub
//
//  Created by Yu on 2022/01/27.
//

import Foundation

struct Opinion: Identifiable {
    var id: String
    var order: Int
    var content :String
    var speakerId: String
    var createdAt: Date
}
