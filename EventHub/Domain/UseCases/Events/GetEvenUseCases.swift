//
//  GetEvenUseCases.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 22.12.25.
//

class GetEventsUseCase {
    
    private let repository: EventRepositoryProtocol
    
    init(repository: EventRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(
        eventTypeId: String? = nil,
        location: String? = nil,
        searchKeyword: String? = nil,
        startDate: String? = nil,
        endDate: String? = nil,
        onlyAvailable: Bool? = nil
    ) async throws -> [Event] {
        return try await repository.getEvents(
            eventTypeId: eventTypeId,
            location: location,
            searchKeyword: searchKeyword,
            startDate: startDate,
            endDate: endDate,
            onlyAvailable: onlyAvailable
        )
    }
}
