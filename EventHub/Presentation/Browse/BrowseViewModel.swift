//
//  BrowseView.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 21.12.25.
//

import SwiftUI
import Combine

@MainActor
final class BrowseViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var searchText = ""
    @Published var selectedCategory = "All"
    @Published var events: [Event] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var showFilters = false
    
    // MARK: - Filter Properties
    @Published var startDate: Date?
    @Published var endDate: Date?
    @Published var selectedLocation: String?
    
    // MARK: - Computed Properties
    var categories: [String] {
        var cats = ["All"]
        let eventCategories = events.map { $0.eventTypeName }.unique().sorted()
        cats.append(contentsOf: eventCategories)
        return cats
    }
    
    var filteredEvents: [Event] {
        events.filter { event in
            let matchesCategory = selectedCategory == "All" || event.eventTypeName == selectedCategory
            let matchesSearch = searchText.isEmpty || event.title.localizedCaseInsensitiveContains(searchText)
            return matchesCategory && matchesSearch
        }
    }
    
    // MARK: - Dependencies
    private let getEventsUseCase: GetEventsUseCase
    
    init(getEventsUseCase: GetEventsUseCase) {
        self.getEventsUseCase = getEventsUseCase
    }
    
    // MARK: - Load Events
    func loadEvents() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let fetchedEvents = try await getEventsUseCase.execute()
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
    
    // MARK: - Refresh Events
    func refreshEvents() async {
        errorMessage = nil
        
        do {
            let fetchedEvents = try await getEventsUseCase.execute()
            self.events = fetchedEvents
        } catch {
            self.errorMessage = "Failed to refresh events"
        }
    }
    
    // MARK: - Reset Filters
    func resetFilters() {
        selectedCategory = "All"
        searchText = ""
        startDate = nil
        endDate = nil
        selectedLocation = nil
    }
}

// MARK: - Array Extension
extension Array where Element: Hashable {
    func unique() -> [Element] {
        Array(Set(self))
    }
}
