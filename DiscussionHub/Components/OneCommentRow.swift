//
//  AllCommentList.swift
//  DiscussionHub
//
//  Created by Yu on 2022/01/31.
//

import SwiftUI

struct OneCommentRow: View {
    
    let showingComment: Comment
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            Divider()
                .padding(.bottom, 6)
            HStack() {
                Text("\(showingComment.order)")
                    .fontWeight(.semibold)
                Text(showingComment.authorDisplayName)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                Text("@\(showingComment.authorDailyId)")
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                Text("\(toHowManyAgo(from: showingComment.createdAt))")
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                Spacer()
                CommentMenu(showingComment: showingComment)
            }
            .padding(.horizontal, 12)
            
            Text(showingComment.content)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.bottom, 6)
                .padding(.horizontal, 12)
        }
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets())
        .padding(6)
        
    }
    
    private func toHowManyAgo(from: Date) -> String {
        let inputDate = from
        
        let secondDiff: Int = (Calendar.current.dateComponents([.second], from: inputDate, to: Date())).second!
        if secondDiff < 60 {
            return "\(secondDiff)秒前"
        }
        
        let minuteDiff = (Calendar.current.dateComponents([.minute], from: inputDate, to: Date())).minute!
        if minuteDiff < 60 {
            return "\(minuteDiff)分前"
        }
        
        let hourDiff = (Calendar.current.dateComponents([.hour], from: inputDate, to: Date())).hour!
        if hourDiff < 24 {
            return "\(hourDiff)時間前"
        }
        
        let dayDiff = (Calendar.current.dateComponents([.day], from: inputDate, to: Date())).day!
        if dayDiff < 31 {
            return "\(dayDiff)日前"
        }
        
        let monthDiff = (Calendar.current.dateComponents([.month], from: inputDate, to: Date())).month!
        if monthDiff < 12 {
            return "\(monthDiff)ヶ月前"
        }

        let yearDiff = (Calendar.current.dateComponents([.year], from: inputDate, to: Date())).year!
        return "\(yearDiff)年前"
    }
}
