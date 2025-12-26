//
//  DIContainer.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 21.12.25.
//

import Foundation

final class DIContainer {
    
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
    
    private lazy var notificationRepository: NotificationRepositoryProtocol = NotificationRepository(
        networkService: networkService
    )
    
    private lazy var registrationRepository: RegistrationRepositoryProtocol = RegistrationRepository(
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
    
    // MARK: - Registration UseCases
    private func makeRegisterForEventUseCase() -> RegisterForEventUseCase {
        return RegisterForEventUseCase(repository: registrationRepository)
    }
    
    private func makeCancelRegistrationUseCase() -> CancelRegistrationUseCase {
        return CancelRegistrationUseCase(repository: registrationRepository)
    }
    
    private func makeGetMyRegistrationsUseCase() -> GetMyRegistrationsUseCase {
        return GetMyRegistrationsUseCase(repository: registrationRepository)
    }
    
    private func makeCheckRegistrationStatusUseCase() -> CheckRegistrationStatusUseCase {
        return CheckRegistrationStatusUseCase(repository: registrationRepository)
    }
    
    // MARK: - Notification UseCases
    private func makeGetNotificationsUseCase() -> GetNotificationsUseCase {
        return GetNotificationsUseCase(repository: notificationRepository)
    }
    
    // MARK: - Home ViewModel
    func makeHomeViewModel() -> HomeViewModel {
        return HomeViewModel(getEventsUseCase: makeGetEventsUseCase())
    }
    
    // MARK: - Browse ViewModel
    func makeBrowseViewModel() -> BrowseViewModel {
        return BrowseViewModel(getEventsUseCase: makeGetEventsUseCase())
    }
    
    // MARK: - Event Detail ViewModel
    func makeEventDetailViewModel(eventId: Int) -> EventDetailViewModel {
        return EventDetailViewModel(
            eventId: eventId,
            getEventDetailUseCase: makeGetEventDetailUseCase(),
            registerForEventUseCase: makeRegisterForEventUseCase(),
            cancelRegistrationUseCase: makeCancelRegistrationUseCase(),
            checkRegistrationStatusUseCase: makeCheckRegistrationStatusUseCase()  
        )
    }
    
    // MARK: - My Events ViewModel
    func makeMyEventsViewModel() -> MyEventsViewModel {
        return MyEventsViewModel(
            getMyRegistrationsUseCase: makeGetMyRegistrationsUseCase()
        )
    }
    
    // MARK: - Notifications ViewModel
    func makeNotificationsViewModel() -> NotificationsViewModel {
        return NotificationsViewModel(getNotificationsUseCase: makeGetNotificationsUseCase())
    }
    
    // MARK: - Profile ViewModel
    func makeProfileViewModel() -> ProfileViewModel {
        return ProfileViewModel(keychainManager: keychainManager)
    }
    
    // MARK: - Helpers
    func getKeychainManager() -> KeychainManager {
        return keychainManager
    }
    
    func getNetworkService() -> NetworkServiceProtocol {
        return networkService
    }
}
