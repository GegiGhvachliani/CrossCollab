//
//  RegisterForEventUseCase.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 24.12.25.
//

import Foundation

class RegisterForEventUseCase {
    
    private let repository: RegistrationRepositoryProtocol
    
    init(repository: RegistrationRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(eventId: Int) async throws -> Registration {
        return try await repository.registerForEvent(eventId: eventId)
    }
}
