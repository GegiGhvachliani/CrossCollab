//
//  AuthRepository.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 21.12.25.
//

import Foundation

class EventRepository: EventRepositoryProtocol {
    
    // MARK: - Dependencies
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    // MARK: - Get Events
    func getEvents(
        eventTypeId: String?,
        location: String?,
        searchKeyword: String?,
        startDate: String?,
        endDate: String?,
        onlyAvailable: Bool?
    ) async throws -> [Event] {
        
        let events = try await networkService.request(
            endpoint: .getEvents(
                eventTypeId: eventTypeId,
                location: location,
                searchKeyword: searchKeyword,
                startDate: startDate,
                endDate: endDate,
                onlyAvailable: onlyAvailable
            ),
            responseType: [Event].self
        )
        
        return events
    }
    
    // MARK: - Get Event Detail
    func getEventDetail(id: Int) async throws -> Event {
        
        let event = try await networkService.request(
            endpoint: .getEventDetail(id: id),
            responseType: Event.self 
        )
        
        return event
    }
}
