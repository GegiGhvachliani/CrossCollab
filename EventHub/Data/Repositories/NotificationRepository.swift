//
//  NotificationRepository.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 21.12.25.
//

import Foundation

class NotificationRepository: NotificationRepositoryProtocol {
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getNotifications() async throws -> [Notification] {
        // ALWAYS return mock data, never call API
        return MockData.notifications
    }
    
    func markAsRead(id: Int) async throws {
        // Mock implementation
        print("📌 Mark notification \(id) as read")
    }
}
