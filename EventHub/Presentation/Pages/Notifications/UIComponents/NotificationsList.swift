//
//  NotificationsList.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 24.12.25.
//

import SwiftUI

// MARK: - Notifications List
struct NotificationsList: View {
    @ObservedObject var viewModel: NotificationsViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                // New notifications
                if !viewModel.newNotifications.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("New")
                            .font(.headline)
                            .padding(.horizontal)
                            .padding(.top, 8)
                        
                        ForEach(viewModel.newNotifications) { notification in
                            if let eventId = notification.eventId {
                                NavigationLink {
                                    EventDetailsView(eventId: eventId)
                                } label: {
                                    NotificationCard(notification: notification)
                                }
                                .buttonStyle(.plain)
                                .simultaneousGesture(TapGesture().onEnded {
                                    viewModel.markAsRead(notificationId: notification.id)
                                })
                            } else {
                                NotificationCard(notification: notification)
                                    .onTapGesture {
                                        viewModel.markAsRead(notificationId: notification.id)
                                    }
                            }
                        }
                    }
                }
                
                if !viewModel.earlierNotifications.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Earlier")
                            .font(.headline)
                            .padding(.horizontal)
                            .padding(.top, viewModel.newNotifications.isEmpty ? 8 : 16)
                        
                        ForEach(viewModel.earlierNotifications) { notification in
                            if let eventId = notification.eventId {
                                NavigationLink {
                                    EventDetailsView(eventId: eventId)
                                } label: {
                                    NotificationCard(notification: notification)
                                }
                                .buttonStyle(.plain)
                            } else {
                                NotificationCard(notification: notification)
                            }
                        }
                    }
                }
            }
            .padding(.vertical)
        }
    }
}
