//
//  RegistrationRepository.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 24.12.25.
//

import Foundation

class RegistrationRepository: RegistrationRepositoryProtocol {
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func registerForEvent(eventId: Int) async throws -> Registration {
        let registration = try await networkService.request(
            endpoint: .registerForEvent(eventId: eventId),
            responseType: Registration.self
        )
        return registration
    }
    
    func cancelRegistration(registrationId: Int) async throws {
        try await networkService.requestWithoutResponse(
            endpoint: .cancelRegistration(registrationId: registrationId)
        )
    }
    
    func getMyRegistrations() async throws -> [Registration] {
        let registrations = try await networkService.request(
            endpoint: .getMyRegistrations,
            responseType: [Registration].self
        )
        return registrations
    }
    
    // NEW: Check if user is registered for a specific event
    func getUserRegistrationForEvent(eventId: Int) async throws -> Registration? {
        let allRegistrations = try await getMyRegistrations()
        return allRegistrations.first { $0.eventId == eventId && !$0.isCancelled }
    }
}
