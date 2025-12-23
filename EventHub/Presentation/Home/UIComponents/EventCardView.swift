//
//  EventCard.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 22.12.25.
//

import SwiftUI

struct EventCardView: View {
    let event: Event
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            
            // CHANGED: Date from backend format
            VStack {
                Text(monthFromDate(event.startDateTime))
                    .font(.caption)
                    .foregroundColor(.gray)
                Text(dayFromDate(event.startDateTime))
                    .font(.title3)
                    .fontWeight(.bold)
            }
            .frame(width: 50)
            
            VStack(alignment: .leading, spacing: 10) {
                // CHANGED: Use real event title
                Text(event.title)
                    .font(.headline)
                
                // CHANGED: Time & location from backend
                HStack(spacing: 8) {
                    Image(systemName: "clock")
                    Text(formatTime(event.startDateTime))
                    Text("•")
                    Image(systemName: "mappin.and.ellipse")
                    Text(event.location)
                }
                .font(.caption)
                .foregroundColor(.gray)
                
                // CHANGED: Optional description
                if let description = event.description {
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
                
                // CHANGED: Registration info from backend
                HStack {
                    HStack(spacing: 4) {
                        Image(systemName: "person.3")
                        Text("\(event.confirmedCount) registered • \(spotsLeftText)")
                    }
                    .font(.caption)
                    .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Text("View Details →")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 4)
    }
    
    // ADDED: Calculate spots left
    private var spotsLeftText: String {
        let spotsLeft = event.capacity - event.confirmedCount
        return event.isFull ? "Full" : "\(spotsLeft) spots left"
    }
    
    // ADDED: Parse month from ISO date
    private func monthFromDate(_ dateString: String) -> String {
        let components = dateString.split(separator: "-")
        guard components.count >= 2, let month = Int(components[1]) else { return "JAN" }
        let months = ["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"]
        return months[month - 1]
    }
    
    // ADDED: Parse day from ISO date
    private func dayFromDate(_ dateString: String) -> String {
        let components = dateString.split(separator: "-")
        guard components.count >= 3 else { return "01" }
        let dayComponent = components[2].split(separator: "T")
        return String(dayComponent[0])
    }
    
    // ADDED: Format time
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
