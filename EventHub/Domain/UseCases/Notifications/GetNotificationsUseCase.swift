//
//  GetNotificationsUseCase.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 24.12.25.
//

import Foundation

class GetNotificationsUseCase {
    
    private let repository: NotificationRepositoryProtocol
    
    init(repository: NotificationRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async throws -> [Notification] {
        return try await repository.getNotifications()
    }
}
