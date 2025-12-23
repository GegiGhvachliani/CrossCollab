//
//  Category.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 22.12.25.
//

import Foundation

struct Category: Identifiable, Hashable {
    let id: String
    let title: String
    let icon: String
    let eventCount: Int
}

// MARK: - Category Icon Mapping
extension Category {
    static func iconForEventType(_ eventType: String) -> String {
        switch eventType.lowercased() {
        case let type where type.contains("team"):
            return "person.3.fill"
        case let type where type.contains("workshop"):
            return "hammer.fill"
        case let type where type.contains("sport"):
            return "sportscourt.fill"
        case let type where type.contains("wellness"):
            return "heart.fill"
        case let type where type.contains("cultural"):
            return "theatermasks.fill"
        case let type where type.contains("friday"):
            return "party.popper.fill"
        default:
            return "calendar.badge.clock"
        }
    }
    
    static func from(events: [Event]) -> [Category] {
        let grouped = Dictionary(grouping: events) { $0.eventTypeName }
        
        return grouped.map { eventType, events in
            Category(
                id: eventType,
                title: eventType,
                icon: iconForEventType(eventType),
                eventCount: events.count
            )
        }
        .sorted { $0.eventCount > $1.eventCount }
    }
}
