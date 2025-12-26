//
//  ForgetPasswordViewModel.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 21.12.25.
//

import SwiftUI
import Combine

@MainActor
final class ForgotPasswordViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    @Published var email = ""
    
    @Published var isLoading = false
    
    @Published var errorMessage: String?
    
    @Published var successMessage: String?
    
    // MARK: - Functions
    
    func sendResetLink() {
        errorMessage = nil
        successMessage = nil
        
        guard !email.isEmpty else {
            errorMessage = "Email is required"
            return
        }
        
        guard email.contains("@") else {
            errorMessage = "Please enter a valid email"
            return
        }
        
        isLoading = true
        
        // MOCK: Simulate sending reset link
        Task {
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            
            isLoading = false
            successMessage = "Password reset link sent! Check your email."

        }
    }
}
