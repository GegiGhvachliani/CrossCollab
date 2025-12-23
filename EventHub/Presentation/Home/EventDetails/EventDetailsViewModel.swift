//
//  EventDetailsViewModel.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 23.12.25.
//

import SwiftUI
import Combine

@MainActor
class EventDetailViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var event: Event?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // MARK: - Dependencies
    private let getEventDetailUseCase: GetEventDetailUseCase
    private let eventId: Int
    
    init(eventId: Int, getEventDetailUseCase: GetEventDetailUseCase) {
        self.eventId = eventId
        self.getEventDetailUseCase = getEventDetailUseCase
    }
    
    // MARK: - Load Event Detail
    func loadEventDetail() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let fetchedEvent = try await getEventDetailUseCase.execute(eventId: eventId)
                self.event = fetchedEvent
                self.isLoading = false
                print("✅ Loaded event: \(fetchedEvent.title)")
                
            } catch let error as NetworkError {
                self.isLoading = false
                self.errorMessage = error.message
                
            } catch {
                self.isLoading = false
                self.errorMessage = "Failed to load event"
            }
        }
    }
    
    // MARK: - Register for Event
    func registerForEvent() {
        // TODO: Implement later with RegisterForEventUseCase
        print("🔵 Register button pressed for event: \(eventId)")
    }
}
