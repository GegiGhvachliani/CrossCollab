//
//  SignInViewModel.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 21.12.25.
//
//
//  SignInViewModel.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 21.12.25.
//

import SwiftUI
import Combine

@MainActor
class SignInViewModel: ObservableObject {
    
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
                errorMessage = error.message
                
            } catch {
                isLoading = false
                errorMessage = "An unexpected error occurred"
            }
        }
    }
    
    // MARK: - Load "Remember Me"
    func loadRememberMe() {
        if UserDefaults.standard.bool(forKey: "rememberMe") {
            rememberMe = true
            email = UserDefaults.standard.string(forKey: "savedEmail") ?? ""
        }
    }
    
    
    //MARK: - testirebisbvis
    //TODO: wasashleleia mere
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
