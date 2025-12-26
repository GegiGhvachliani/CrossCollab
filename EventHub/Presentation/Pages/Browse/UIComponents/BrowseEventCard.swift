//
//  BrowseEventCard.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 23.12.25.
//

import SwiftUI


struct BrowseEventCard: View {
    let event: Event
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            
            VStack(spacing: 4) {
                Text(monthFromDate(event.startDateTime))
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                Text(dayFromDate(event.startDateTime))
                    .font(.system(size: 24, weight: .semibold))
            }
            .frame(width: 50)
            
            VStack(alignment: .leading, spacing: 8) {
                
                HStack {
                    Text(event.eventTypeName)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    
                    Spacer()
                    
                    if event.isFull {
                        Text("Full")
                            .font(.caption)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.red.opacity(0.1))
                            .foregroundColor(.red)
                            .cornerRadius(8)
                    }
                }
                
                Text(event.title)
                    .font(.system(size: 16, weight: .semibold))
                    .lineLimit(2)
                
                HStack(spacing: 4) {
                    Image(systemName: "clock")
                    Text(formatTime(event.startDateTime))
                }
                .font(.system(size: 12))
                .foregroundColor(.secondary)
                
                HStack(spacing: 4) {
                    Image(systemName: "mappin.and.ellipse")
                    Text(event.location)
                }
                .font(.system(size: 12))
                .foregroundColor(.secondary)
                
                HStack(spacing: 12) {
                    HStack(spacing: 4) {
                        Image(systemName: "person.2")
                        Text("\(event.confirmedCount) registered")
                    }
                    
                    HStack(spacing: 4) {
                        Image(systemName: "chair")
                        Text("\(event.capacity - event.confirmedCount) spots left")
                    }
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
    }
    
    private func monthFromDate(_ dateString: String) -> String {
        let components = dateString.split(separator: "-")
        guard components.count >= 2, let month = Int(components[1]) else { return "JAN" }
        let months = ["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"]
        return months[month - 1]
    }
    
    private func dayFromDate(_ dateString: String) -> String {
        let components = dateString.split(separator: "-")
        guard components.count >= 3 else { return "01" }
        let dayComponent = components[2].split(separator: "T")
        return String(dayComponent[0])
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
