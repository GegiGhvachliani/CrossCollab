//
//  NotificationsViewModel.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 24.12.25.
//

import SwiftUI
import Combine

@MainActor
final class NotificationsViewModel: ObservableObject {
    
    @Published var notifications: [Notification] = []
    @Published var selectedType: NotificationType = .all
    @Published var selectedNotification: Notification?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    var filteredNotifications: [Notification] {
        if selectedType == .all {
            return notifications
        }
        return notifications.filter { selectedType.matches($0.type) }
    }
    
    var newNotifications: [Notification] {
        filteredNotifications.filter { $0.isNew }
    }
    
    var earlierNotifications: [Notification] {
        filteredNotifications.filter { !$0.isNew }
    }
    
    private let getNotificationsUseCase: GetNotificationsUseCase
    
    init(getNotificationsUseCase: GetNotificationsUseCase) {
        self.getNotificationsUseCase = getNotificationsUseCase
    }
    
    func loadNotifications() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                try await Task.sleep(nanoseconds: 500_000_000)
                self.notifications = MockData.notifications
                self.isLoading = false
                print("✅ Loaded \(MockData.notifications.count) mock notifications")
            } catch {
                self.isLoading = false
                print("⚠️ Load cancelled")
            }
        }
    }
    
    func refreshNotifications() async {
        do {
            // Simulate refresh
            try await Task.sleep(nanoseconds: 300_000_000)
            self.notifications = MockData.notifications
            print("✅ Refreshed mock notifications")
        } catch {
            print("⚠️ Refresh cancelled")
        }
    }
    
    func markAsRead(notificationId: Int) {
        if let index = notifications.firstIndex(where: { $0.id == notificationId }) {
            notifications[index] = Notification(
                id: notifications[index].id,
                type: notifications[index].type,
                title: notifications[index].title,
                message: notifications[index].message,
                eventId: notifications[index].eventId,
                createdAt: notifications[index].createdAt,
                isRead: true
            )
        }
    }
    
    func deleteNotification(notificationId: Int) {
        notifications.removeAll { $0.id == notificationId }
    }
}
