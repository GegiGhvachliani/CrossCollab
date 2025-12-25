//
//  NotificationsViewModel.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 23.12.25.
//

import SwiftUI
import Combine

@MainActor
class NotificationsViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var notifications: [Notification] = []
    @Published var selectedType: NotificationType = .all
    @Published var selectedNotification: Notification?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // MARK: - Computed Properties
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
    
    // MARK: - Dependencies
    private let getNotificationsUseCase: GetNotificationsUseCase
    
    init(getNotificationsUseCase: GetNotificationsUseCase) {
        self.getNotificationsUseCase = getNotificationsUseCase
    }
    
    // MARK: - Load Notifications
    func loadNotifications() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let fetchedNotifications = try await getNotificationsUseCase.execute()
                self.notifications = fetchedNotifications
                self.isLoading = false
                
            } catch let error as NetworkError {
                self.isLoading = false
                self.errorMessage = error.message
                
            } catch {
                self.isLoading = false
                self.errorMessage = "Failed to load notifications"
            }
        }
    }
    
    // MARK: - Refresh Notifications
    func refreshNotifications() async {
        errorMessage = nil
        
        do {
            let fetchedNotifications = try await getNotificationsUseCase.execute()
            self.notifications = fetchedNotifications
        } catch {
            self.errorMessage = "Failed to refresh notifications"
        }
    }
}