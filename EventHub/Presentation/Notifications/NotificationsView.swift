//
//  NotificationsView.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 23.12.25.
//

import SwiftUI

struct NotificationsView: View {
    @StateObject var viewModel: NotificationsViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                // Type Filter Picker
                Picker("", selection: $viewModel.selectedType) {
                    ForEach(NotificationType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                
                // Content
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let error = viewModel.errorMessage {
                    ErrorView(message: error) {
                        viewModel.loadNotifications()
                    }
                } else if viewModel.filteredNotifications.isEmpty {
                    EmptyNotificationsView()
                } else {
                    NotificationsList(viewModel: viewModel)
                }
            }
            .navigationTitle("Notifications")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(item: $viewModel.selectedNotification) { notification in
                NotificationDetailSheet(notification: notification)
            }
            .onAppear {
                viewModel.loadNotifications()
            }
            .refreshable {
                await viewModel.refreshNotifications()
            }
        }
    }
}

// MARK: - Notifications List
struct NotificationsList: View {
    @ObservedObject var viewModel: NotificationsViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                // New Notifications
                if !viewModel.newNotifications.isEmpty {
                    Text("New")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ForEach(viewModel.newNotifications) { notification in
                        NotificationCard(notification: notification)
                            .onTapGesture {
                                viewModel.selectedNotification = notification
                            }
                    }
                }
                
                // Earlier Notifications
                if !viewModel.earlierNotifications.isEmpty {
                    Text("Earlier")
                        .font(.headline)
                        .padding(.horizontal)
                        .padding(.top, viewModel.newNotifications.isEmpty ? 0 : 8)
                    
                    ForEach(viewModel.earlierNotifications) { notification in
                        NotificationCard(notification: notification)
                            .onTapGesture {
                                viewModel.selectedNotification = notification
                            }
                    }
                }
            }
            .padding(.vertical)
        }
    }
}

// MARK: - Notification Card
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

// MARK: - Notification Detail Sheet
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
                
                // Actions
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

// MARK: - Empty Notifications View
struct EmptyNotificationsView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "bell.slash")
                .font(.system(size: 50))
                .foregroundColor(.gray)
            
            Text("No Notifications")
                .font(.system(size: 20, weight: .semibold))
            
            Text("You're all caught up!")
                .font(.system(size: 14))
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    NotificationsView(viewModel: DIContainer.shared.makeNotificationsViewModel())
}