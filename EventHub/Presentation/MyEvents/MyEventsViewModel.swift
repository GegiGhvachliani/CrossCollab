//
//  MyEventsView.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 21.12.25.
//

import SwiftUI
import Combine

enum ViewMode: String, CaseIterable {
    case list = "List"
    case calendar = "Calendar"
}

@MainActor
class MyEventsViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var registrations: [Registration] = []
    @Published var viewMode: ViewMode = .calendar
    @Published var selectedDate = Date()
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // MARK: - Computed Properties
    var upcomingEvent: Registration? {
        let now = Date()
        return registrations
            .filter { parseDate($0.startDateTime) > now && $0.eventIsActive }
            .sorted { parseDate($0.startDateTime) < parseDate($1.startDateTime) }
            .first
    }
    
    var eventsForSelectedDate: [Registration] {
        registrations.filter { registration in
            let eventDate = parseDate(registration.startDateTime)
            return Calendar.current.isDate(eventDate, inSameDayAs: selectedDate) && registration.eventIsActive
        }
    }
    
    var allMyEvents: [Registration] {
        registrations
            .filter { $0.eventIsActive }
            .sorted { parseDate($0.startDateTime) < parseDate($1.startDateTime) }
    }
    
    // MARK: - Dependencies
    private let getMyRegistrationsUseCase: GetMyRegistrationsUseCase
    
    init(getMyRegistrationsUseCase: GetMyRegistrationsUseCase) {
        self.getMyRegistrationsUseCase = getMyRegistrationsUseCase
    }
    
    // MARK: - Load Data
    func loadMyEvents() {
        // Don't reload if already loading
        guard !isLoading else { return }  // NEW
        
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let registrations = try await getMyRegistrationsUseCase.execute()
                self.registrations = registrations
                self.isLoading = false
                
                print("✅ Loaded \(registrations.count) registrations")
                
            } catch let error as NetworkError {
                self.isLoading = false
                self.errorMessage = error.message
                
            } catch {
                self.isLoading = false
                self.errorMessage = "Failed to load events"
            }
        }
    }
    
    // MARK: - Refresh
    func refreshMyEvents() async {
        // CHANGED: Don't set error message during refresh
        // Only set if actual error occurs
        
        do {
            let registrations = try await getMyRegistrationsUseCase.execute()
            self.registrations = registrations
            print("✅ Refreshed \(registrations.count) registrations")
            
        } catch let error as NetworkError {
            // Only set error if it's not a 401 (unauthorized during refresh is OK)
            if case .unauthorized = error {
                print("⚠️ Refresh failed: Not authorized (token may have expired)")
            } else {
                self.errorMessage = error.message
            }
        } catch {
            self.errorMessage = "Failed to refresh events"
        }
    }
    
    // MARK: - Helper
    private func parseDate(_ dateString: String) -> Date {
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: dateString) ?? Date()
    }
}
