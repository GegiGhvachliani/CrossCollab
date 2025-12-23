//
//  HomeView.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 21.12.25.
//

import SwiftUI
import Combine

@MainActor
class HomeViewModel: ObservableObject {
    
    // MARK: - Published Properties
        @Published var userName: String = "User"
        @Published var events: [Event] = []
        @Published var categories: [Category] = []
        @Published var trendingEvents: [Event] = []
    
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // MARK: - Dependencies
    private let getEventsUseCase: GetEventsUseCase
    
    init(getEventsUseCase: GetEventsUseCase) {
        self.getEventsUseCase = getEventsUseCase
        loadUserName()
    }
    
    // MARK: - Load User Name
    private func loadUserName() {
        if let name = UserDefaults.standard.string(forKey: "userFullName") {
            userName = name
        }
    }
    
    // MARK: - Load Events
    func loadEvents() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let fetchedEvents = try await getEventsUseCase.execute()
                
                self.events = fetchedEvents
                self.categories = Category.from(events: fetchedEvents)
                self.trendingEvents = fetchedEvents
                    .sorted { $0.confirmedCount > $1.confirmedCount }
                    .prefix(5) // Top 5
                    .map { $0 }
                
                self.isLoading = false
                
                print("✅ Loaded \(fetchedEvents.count) events")
                print("✅ Found \(categories.count) categories")
                print("✅ Top trending: \(trendingEvents.first?.title ?? "none")")
                
            } catch let error as NetworkError {
                self.isLoading = false
                self.errorMessage = error.message
                print("❌ Error: \(error.message)")
                
            } catch {
                self.isLoading = false
                self.errorMessage = "Failed to load events"
                print("❌ Unexpected error: \(error)")
            }
        }
    }
    
    // MARK: - Refresh Events
    func refreshEvents() async {
        errorMessage = nil
        
        do {
            let fetchedEvents = try await getEventsUseCase.execute()
            
            self.events = fetchedEvents
            self.categories = Category.from(events: fetchedEvents)
            self.trendingEvents = fetchedEvents
                .sorted { $0.confirmedCount > $1.confirmedCount }
                .prefix(5)
                .map { $0 }
            
            print("🔄 Refreshed")
            
        } catch let error as NetworkError {
            self.errorMessage = error.message
        } catch {
            self.errorMessage = "Failed to refresh events"
        }
    }
}
