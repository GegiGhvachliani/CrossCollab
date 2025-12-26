//
//  SignInViewModel.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 21.12.25.
//

import SwiftUI
import Combine

@MainActor
final class SignInViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var email = ""
    @Published var password = ""
    @Published var rememberMe = false
    
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // MARK: - Dependencies
    private let keychainManager = DIContainer.shared.getKeychainManager()
    private let networkService = DIContainer.shared.getNetworkService()
    
    // MARK: - Sign In Function
    func signIn(authCoordinator: AuthCoordinator) {
        guard !email.isEmpty else {
            errorMessage = "Email is required"
            return
        }
        
        guard !password.isEmpty else {
            errorMessage = "Password is required"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let response = try await networkService.request(
                    endpoint: .login(email: email, password: password),
                    responseType: AuthResponse.self
                )
                
                keychainManager.saveToken(response.token)
                
                UserDefaults.standard.set(response.fullName, forKey: "userFullName")
                UserDefaults.standard.set(response.userId, forKey: "userId")
                UserDefaults.standard.set(email, forKey: "userEmail")
                
                if rememberMe {
                    UserDefaults.standard.set(true, forKey: "rememberMe")
                    UserDefaults.standard.set(email, forKey: "savedEmail")
                } else {
                    UserDefaults.standard.removeObject(forKey: "rememberMe")
                    UserDefaults.standard.removeObject(forKey: "savedEmail")
                }
                
                isLoading = false
                authCoordinator.didAuthenticate()
                
            } catch let error as NetworkError {
                isLoading = false
                errorMessage = userFriendlyErrorMessage(for: error)
                
            } catch {
                isLoading = false
                errorMessage = "Unable to sign in. Please try again"
            }
        }
    }
    
    private func userFriendlyErrorMessage(for error: NetworkError) -> String {
        switch error {
        case .unauthorized:
            return "Invalid email or password"
        case .serverError(let code):
            if code == 401 {
                return "Invalid email or password"
            } else if code >= 500 {
                return "Server is currently unavailable"
            } else {
                return "Unable to sign in. Please try again"
            }
        case .invalidURL:
            return "Connection error. Please try again"
        case .noData:
            return "No response from server"
        case .decodingError:
            return "Unable to process server response"
        case .unknown:
            return "Connection failed. Please check your internet"
        }
    }
    
    func loadRememberMe() {
        if UserDefaults.standard.bool(forKey: "rememberMe") {
            rememberMe = true
            email = UserDefaults.standard.string(forKey: "savedEmail") ?? ""
        }
    }
    
    func testNetworkLayer() {
        Task {
            do {
                let response = try await networkService.request(
                    endpoint: .login(email: "test@test.com", password: "password"),
                    responseType: AuthResponse.self
                )
                print("✅ Success: \(response)")
            } catch let error as NetworkError {
                print("❌ Network Error: \(error.message)")
            } catch {
                print("❌ Unexpected Error: \(error)")
            }
        }
    }
}
