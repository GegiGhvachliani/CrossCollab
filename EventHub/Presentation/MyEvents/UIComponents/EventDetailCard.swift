//
//  EventDetailCard.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 24.12.25.
//

import SwiftUI


struct EventDetailCard: View {
    let registration: Registration  // CHANGED
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            VStack {
                Text(formatHour(registration.startDateTime))
                    .font(.title3)
                    .fontWeight(.semibold)
                Text(formatAMPM(registration.startDateTime))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .frame(width: 60)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(registration.eventTitle)
                    .font(.headline)
                
                Text(registration.eventType)
                    .font(.subheadline)
                    .foregroundColor(.blue)
                
                HStack(spacing: 6) {
                    Image(systemName: "mappin.and.ellipse")
                    Text(registration.location)
                }
                .font(.caption)
                .foregroundColor(.gray)
                
                // Status
                HStack {
                    Image(systemName: registration.isConfirmed ? "checkmark.circle.fill" : "clock.fill")
                    Text(registration.status)
                }
                .font(.caption2)
                .foregroundColor(registration.isConfirmed ? .green : .orange)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 4)
        .padding(.horizontal)
    }
    
    private func formatHour(_ dateString: String) -> String {
        let components = dateString.split(separator: "T")
        guard components.count >= 2 else { return "TBA" }
        let timeComponent = components[1].split(separator: ":")
        guard let hour = Int(timeComponent[0]) else { return "TBA" }
        let displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour)
        return String(format: "%02d:00", displayHour)
    }
    
    private func formatAMPM(_ dateString: String) -> String {
        let components = dateString.split(separator: "T")
        guard components.count >= 2 else { return "" }
        let timeComponent = components[1].split(separator: ":")
        guard let hour = Int(timeComponent[0]) else { return "" }
        return hour >= 12 ? "PM" : "AM"
    }
}
