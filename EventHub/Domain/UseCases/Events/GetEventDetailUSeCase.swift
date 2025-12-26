//
//  GetEventDetailUSeCase.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 22.12.25.
//

import Foundation

class GetEventDetailUseCase {
    
    private let repository: EventRepositoryProtocol
    
    init(repository: EventRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(eventId: Int) async throws -> Event {
        return try await repository.getEventDetail(id: eventId)
    }
}
