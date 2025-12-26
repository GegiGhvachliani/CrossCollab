//
//  EventRepositoryProtocol.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 22.12.25.
//


import Foundation

protocol EventRepositoryProtocol {
    
    func getEvents(
        eventTypeId: String?,
        location: String?,
        searchKeyword: String?,
        startDate: String?,
        endDate: String?,
        onlyAvailable: Bool?
    ) async throws -> [Event]
    
    func getEventDetail(id: Int) async throws -> Event
}
