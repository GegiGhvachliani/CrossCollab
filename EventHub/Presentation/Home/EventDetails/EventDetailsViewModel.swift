//
//  EventDetailViewModel.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 23.12.25.
//

import SwiftUI
import Combine

@MainActor
class EventDetailViewModel: ObservableObject {
    
    @Published var event: Event?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    @Published var registrationStatus: String?
    @Published var registrationId: Int?
    @Published var isRegistering = false
    
    // NEW: Mock data properties (not from API)
    @Published var agenda: [AgendaItem]?
    @Published var speakers: [Speaker]?
    
    var isRegistered: Bool {
        registrationId != nil && registrationStatus != nil && registrationStatus != "Cancelled"
    }
    
    var buttonText: String {
        if isRegistering {
            return "Loading..."
        }
        
        if isRegistered {
            return "Cancel Registration"
        }
        
        return "Register"
    }
    
    private let getEventDetailUseCase: GetEventDetailUseCase
    private let registerForEventUseCase: RegisterForEventUseCase
    private let cancelRegistrationUseCase: CancelRegistrationUseCase
    private let checkRegistrationStatusUseCase: CheckRegistrationStatusUseCase
    private let eventId: Int
    
    init(
        eventId: Int,
        getEventDetailUseCase: GetEventDetailUseCase,
        registerForEventUseCase: RegisterForEventUseCase,
        cancelRegistrationUseCase: CancelRegistrationUseCase,
        checkRegistrationStatusUseCase: CheckRegistrationStatusUseCase
    ) {
        self.eventId = eventId
        self.getEventDetailUseCase = getEventDetailUseCase
        self.registerForEventUseCase = registerForEventUseCase
        self.cancelRegistrationUseCase = cancelRegistrationUseCase
        self.checkRegistrationStatusUseCase = checkRegistrationStatusUseCase
    }
    
    func loadEventDetail() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let fetchedEvent = try await getEventDetailUseCase.execute(eventId: eventId)
                self.event = fetchedEvent
                
                // NEW: Inject mock agenda and speakers
                self.agenda = MockData.generateAgenda(for: eventId)
                self.speakers = MockData.generateSpeakers(for: eventId)
                
                try await checkRegistrationStatus()
                
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
    
    private func checkRegistrationStatus() async throws {
        do {
            let registration = try await checkRegistrationStatusUseCase.execute(eventId: eventId)
            
            if let registration = registration {
                self.registrationStatus = registration.status
                self.registrationId = registration.registrationId
                print("✅ User is registered: \(registration.status)")
            } else {
                self.registrationStatus = nil
                self.registrationId = nil
                print("ℹ️ User is not registered")
            }
        } catch {
            self.registrationStatus = nil
            self.registrationId = nil
            print("⚠️ Could not check registration status")
        }
    }
    
    func handleRegistrationAction() {
        if isRegistered {
            cancelRegistration()
        } else {
            registerForEvent()
        }
    }
    
    func registerForEvent() {
        isRegistering = true
        errorMessage = nil
        
        Task {
            do {
                let registration = try await registerForEventUseCase.execute(eventId: eventId)
                
                self.registrationStatus = registration.status
                self.registrationId = registration.registrationId
                self.isRegistering = false
                
                print("✅ Registered: \(registration.status)")
                
                await reloadEventData()
                
            } catch let error as NetworkError {
                self.isRegistering = false
                
                switch error {
                case .serverError(409):
                    self.errorMessage = "You are already registered for this event"
                    Task {
                        try? await checkRegistrationStatus()
                    }
                case .serverError(404):
                    self.errorMessage = "Event not found"
                case .unauthorized:
                    self.errorMessage = "Please log in to register"
                default:
                    self.errorMessage = error.message
                }
                
            } catch {
                self.isRegistering = false
                self.errorMessage = "Failed to register. Please try again"
            }
        }
    }
    
    func cancelRegistration() {
        guard let registrationId = registrationId else { return }
        
        isRegistering = true
        errorMessage = nil
        
        Task {
            do {
                try await cancelRegistrationUseCase.execute(registrationId: registrationId)
                
                self.registrationStatus = nil
                self.registrationId = nil
                self.isRegistering = false
                
                print("✅ Registration cancelled")
                
                await reloadEventData()
                
            } catch let error as NetworkError {
                self.isRegistering = false
                self.errorMessage = error.message
                
            } catch {
                self.isRegistering = false
                self.errorMessage = "Failed to cancel registration"
            }
        }
    }
    
    private func reloadEventData() async {
        do {
            let fetchedEvent = try await getEventDetailUseCase.execute(eventId: eventId)
            self.event = fetchedEvent
            print("✅ Reloaded event with updated counts")
        } catch {
            print("⚠️ Failed to reload event data")
        }
    }
}
