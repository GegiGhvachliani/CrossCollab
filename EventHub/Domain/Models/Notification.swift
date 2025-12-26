//
//  Notification.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 21.12.25.
//

import Foundation

struct Notification: Identifiable, Codable, Hashable {
    let id: Int
    let type: String
    let title: String
    let message: String
    let eventId: Int?
    let createdAt: String
    let isRead: Bool
}

// MARK: - Notification Type Enum
enum NotificationType: String, CaseIterable {
    case all = "All"
    case registrations = "Registrations"
    case reminders = "Reminders"
    case updates = "Updates"
    
    func matches(_ notificationType: String) -> Bool {
        switch self {
        case .all:
            return true
        case .registrations:
            return notificationType.contains("Registration")
        case .reminders:
            return notificationType.contains("Reminder")
        case .updates:
            return notificationType.contains("Update") || notificationType.contains("Waitlist") || notificationType.contains("Event")
        }
    }
}

// MARK: - Helpers
extension Notification {
    var isNew: Bool {
        !isRead
    }
    
    var relativeTime: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        
        let isoFormatter = ISO8601DateFormatter()
        guard let date = isoFormatter.date(from: createdAt) else {
            return "Recently"
        }
        
        return formatter.localizedString(for: date, relativeTo: Date())
    }
}
