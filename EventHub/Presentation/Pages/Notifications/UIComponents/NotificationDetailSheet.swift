//
//  NotificationDetailSheet.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 24.12.25.
//

import SwiftUI


struct NotificationDetailSheet: View {
    let notification: Notification
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                VStack(spacing: 12) {
                    Text(notification.title)
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Text(notification.message)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding()
                
                Divider()
                
                if let eventId = notification.eventId {
                    NavigationLink {
                        EventDetailsView(eventId: eventId)
                    } label: {
                        HStack {
                            Image(systemName: "calendar")
                            Text("View Event Details")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue.opacity(0.1))
                        .foregroundColor(.blue)
                        .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
                
                Button("Close") {
                    dismiss()
                }
                .fontWeight(.semibold)
                .padding(.bottom)
            }
            .navigationTitle("Notification")
            .navigationBarTitleDisplayMode(.inline)
        }
        .presentationDetents([.medium])
    }
}
