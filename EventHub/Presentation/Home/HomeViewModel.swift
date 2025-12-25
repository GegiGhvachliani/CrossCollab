//
//  HomeViewModel.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 21.12.25.
//

import SwiftUI
import Combine

@MainActor
class HomeViewModel: ObservableObject {
    
    @Published var events: [Event] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let getEventsUseCase: GetEventsUseCase
    
    init(getEventsUseCase: GetEventsUseCase) {
        self.getEventsUseCase = getEventsUseCase
    }
    
    var trendingEvents: [Event] {
        events
            .filter { !$0.isFull }
            .sorted { ($0.confirmedCount) > ($1.confirmedCount) }
            .prefix(5)
            .map { $0 }
    }
    
    var categorizedEvents: [(category: String, events: [Event])] {
        let eventTypes = Dictionary(grouping: events) { $0.eventTypeName }
        return eventTypes.map { (category: $0.key, events: $0.value) }
            .sorted { $0.category < $1.category }
    }
    
    func loadEvents() {
        guard !isLoading else { return }
        
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let fetchedEvents = try await getEventsUseCase.execute(
                    eventTypeId: nil,
                    location: nil,
                    searchKeyword: nil,
                    startDate: nil,
                    endDate: nil,
                    onlyAvailable: nil
                )
                
                self.events = fetchedEvents
                self.isLoading = false
                
            } catch let error as NetworkError {
                self.isLoading = false
                self.errorMessage = error.message
                
            } catch {
                self.isLoading = false
                self.errorMessage = "Failed to load events"
            }
        }
    }
    
    func refreshEvents() async {
        do {
            let fetchedEvents = try await getEventsUseCase.execute(
                eventTypeId: nil,
                location: nil,
                searchKeyword: nil,
                startDate: nil,
                endDate: nil,
                onlyAvailable: nil
            )
            
            self.events = fetchedEvents
            print("✅ Refreshed events")
            
        } catch let error as NetworkError {
            if case .unauthorized = error {
                print("⚠️ Refresh failed: Not authorized")
            } else {
                print("⚠️ Refresh error: \(error.message)")
            }
        } catch {
            print("⚠️ Refresh failed: \(error)")
        }
    }
}
