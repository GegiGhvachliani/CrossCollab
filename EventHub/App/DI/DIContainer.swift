//
//  DIContainer.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 21.12.25.
//

import Foundation

class DIContainer {
    
    static let shared = DIContainer()
    
    private init() {}
    
    // MARK: - Storage
    private lazy var keychainManager: KeychainManager = KeychainManager()
    
    // MARK: - Network
    private lazy var networkService: NetworkServiceProtocol = NetworkService(
        keychainManager: keychainManager
    )
    
    // MARK: - Repositories
    private lazy var eventRepository: EventRepositoryProtocol = EventRepository(
        networkService: networkService
    )
    
    // MARK: - Coordinators
    func makeAppCoordinator() -> AppCoordinator {
        return AppCoordinator(keychainManager: keychainManager)
    }
    
    func makeAuthCoordinator() -> AuthCoordinator {
        return AuthCoordinator()
    }
    
    // MARK: - Auth ViewModels
    func makeSignInViewModel() -> SignInViewModel {
        return SignInViewModel()
    }
    
    func makeCreateAccountViewModel() -> CreateAccountViewModel {
        return CreateAccountViewModel()
    }
    
    func makeForgotPasswordViewModel() -> ForgotPasswordViewModel {
        return ForgotPasswordViewModel()
    }
    
    // MARK: - Event UseCases
    private func makeGetEventsUseCase() -> GetEventsUseCase {
        return GetEventsUseCase(repository: eventRepository)
    }
    
    private func makeGetEventDetailUseCase() -> GetEventDetailUseCase {
        return GetEventDetailUseCase(repository: eventRepository)
    }
    
    // MARK: - Main Tab ViewModels
    func makeHomeViewModel() -> HomeViewModel {
        return HomeViewModel(getEventsUseCase: makeGetEventsUseCase())
    }
    
    // TODO: Add later
    
    // MARK: - Helpers
    func getKeychainManager() -> KeychainManager {
        return keychainManager
    }
    
    func getNetworkService() -> NetworkServiceProtocol {
        return networkService
    }
    
    // MARK: - Event Detail ViewModels
    func makeEventDetailViewModel(eventId: Int) -> EventDetailViewModel {
        return EventDetailViewModel(
            eventId: eventId,
            getEventDetailUseCase: makeGetEventDetailUseCase()
        )
    }
}
