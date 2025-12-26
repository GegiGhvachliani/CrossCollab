//
//  RegistrationRepositoryProtocol.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 24.12.25.
//

import Foundation

import Foundation

protocol RegistrationRepositoryProtocol {
    func registerForEvent(eventId: Int) async throws -> Registration
    func cancelRegistration(registrationId: Int) async throws
    func getMyRegistrations() async throws -> [Registration]
    func getUserRegistrationForEvent(eventId: Int) async throws -> Registration?
}
