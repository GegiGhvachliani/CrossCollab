//
//  NotificationCard.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 24.12.25.
//

import SwiftUI

struct NotificationCard: View {
    let notification: Notification
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            
            Image(systemName: iconName)
                .font(.title3)
                .foregroundColor(.blue)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(notification.title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Text(notification.message)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                
                Text(notification.relativeTime)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            if notification.isNew {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 8, height: 8)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 4)
        .padding(.horizontal)
    }
    
    private var iconName: String {
        if notification.type.contains("Registration") {
            return "calendar"
        } else if notification.type.contains("Reminder") {
            return "bell.badge"
        } else if notification.type.contains("Update") {
            return "arrow.triangle.2.circlepath"
        } else if notification.type.contains("Waitlist") {
            return "clock.badge.checkmark"
        }
        return "bell"
    }
}
