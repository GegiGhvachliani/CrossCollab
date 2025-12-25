//
//  CancelRegistrationUseCase.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 23.12.25.
//

import Foundation

class CancelRegistrationUseCase {
    
    private let repository: RegistrationRepositoryProtocol
    
    init(repository: RegistrationRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(registrationId: Int) async throws {
        return try await repository.cancelRegistration(registrationId: registrationId)
    }
}