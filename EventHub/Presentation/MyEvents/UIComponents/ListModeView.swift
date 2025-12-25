//
//  ListModeView.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 24.12.25.
//

import SwiftUI


struct ListModeView: View {
    @ObservedObject var viewModel: MyEventsViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("All My Events")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                ForEach(viewModel.allMyEvents) { registration in  // CHANGED
                    NavigationLink {
                        EventDetailsView(eventId: registration.eventId)
                    } label: {
                        RegistrationCard(registration: registration)  // NEW card
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.vertical)
        }
        .background(Color(.systemGray6))
    }
}

// MARK: - Registration Card (for list view)
struct RegistrationCard: View {
    let registration: Registration
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(registration.eventTitle)
                    .font(.headline)
                Spacer()
                HStack {
                    Image(systemName: registration.isConfirmed ? "checkmark.circle.fill" : "clock.fill")
                    Text(registration.status)
                }
                .font(.caption)
                .foregroundColor(registration.isConfirmed ? .green : .orange)
            }
            
            Text(registration.eventType)
                .font(.subheadline)
                .foregroundColor(.blue)
            
            HStack {
                Image(systemName: "calendar")
                Text(formatDate(registration.startDateTime))
            }
            .font(.caption)
            .foregroundColor(.gray)
            
            HStack {
                Image(systemName: "mappin.and.ellipse")
                Text(registration.location)
            }
            .font(.caption)
            .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 4)
        .padding(.horizontal)
    }
    
    private func formatDate(_ dateString: String) -> String {
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: dateString) {
            return date.formatted(date: .abbreviated, time: .shortened)
        }
        return dateString
    }
}


