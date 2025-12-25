//
//  CancelRegistrationUseCase.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 24.12.25.
//


import Foundation

final class CancelRegistrationUseCase {
    
    private let repository: RegistrationRepositoryProtocol
    
    init(repository: RegistrationRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(registrationId: Int) async throws {
        return try await repository.cancelRegistration(registrationId: registrationId)
    }
}
