//
//  EventInfoSection.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 23.12.25.
//

import SwiftUI


struct EventInfoSection: View {
    let event: Event
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(event.title)
                .font(.system(size: 24, weight: .medium))
            
            EventDetailRow(icon: "calendar", text: formatDate(event.startDateTime))
            EventDetailRow(icon: "clock", text: formatTime(event.startDateTime))
            EventDetailRow(icon: "mappin.and.ellipse", text: event.location)
            EventDetailRow(icon: "person.3", text: "\(event.confirmedCount) registered • \(spotsLeftText)")
        }
        .padding(.horizontal)
    }
    
    private var spotsLeftText: String {
        let spotsLeft = event.capacity - event.confirmedCount
        return event.isFull ? "Full" : "\(spotsLeft) spots left"
    }
    
    private func formatDate(_ dateString: String) -> String {
        let components = dateString.split(separator: "-")
        guard components.count >= 3 else { return "TBA" }
        let month = components[1]
        let day = components[2].split(separator: "T")[0]
        return "\(month)/\(day)"
    }
    
    private func formatTime(_ dateString: String) -> String {
        let components = dateString.split(separator: "T")
        guard components.count >= 2 else { return "TBA" }
        let timeComponent = components[1].split(separator: ":")
        guard let hour = Int(timeComponent[0]) else { return "TBA" }
        let isPM = hour >= 12
        let displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour)
        let period = isPM ? "PM" : "AM"
        return "\(displayHour):00 \(period)"
    }
}
