//
//  GetMyRegistrationsUseCase.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 23.12.25.
//

import Foundation

class GetMyRegistrationsUseCase {
    
    private let repository: RegistrationRepositoryProtocol
    
    init(repository: RegistrationRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async throws -> [Registration] {
        return try await repository.getMyRegistrations()
    }
}