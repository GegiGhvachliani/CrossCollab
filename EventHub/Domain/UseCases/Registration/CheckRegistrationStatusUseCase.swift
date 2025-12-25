//
//  CheckRegistrationStatusUseCase.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 25.12.25.
//

import Foundation

class CheckRegistrationStatusUseCase {
    
    private let repository: RegistrationRepositoryProtocol
    
    init(repository: RegistrationRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(eventId: Int) async throws -> Registration? {
        return try await repository.getUserRegistrationForEvent(eventId: eventId)
    }
}