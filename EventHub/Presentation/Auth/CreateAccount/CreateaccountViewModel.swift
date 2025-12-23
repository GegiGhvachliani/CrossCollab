//
//  CreateaccountViewModel.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 21.12.25.
//

import SwiftUI
import Combine

@MainActor
class CreateAccountViewModel: ObservableObject {
    
    // MARK: - Personal Info
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var email = ""
    @Published var phoneNumber = ""
    
    // MARK: - OTP Verification
    @Published var otpCode = ""
    @Published var otpTimer = 60
    @Published var canResendOTP = false
    
    // MARK: - Department Selection
    @Published var selectedDepartment: Department?
    @Published var departments: [Department] = []
    @Published var isDepartmentExpanded = false
    
    // MARK: - Password
    @Published var password = ""
    @Published var confirmPassword = ""
    
    // MARK: - Terms Agreement
    @Published var agreedToTerms = false
    
    // MARK: - UI State
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // MARK: - Dependencies
    private let keychainManager = KeychainManager()
    private var timerCancellable: AnyCancellable?
    
    // MARK: - OTP Functions
    func sendOTP() {
        guard !phoneNumber.isEmpty else {
            errorMessage = "Phone number is required"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        // MOCK: Simulate sending OTP
        Task {
            try? await Task.sleep(nanoseconds: 1_000_000_000)  // 1 second delay
            
            isLoading = false
            
            startOTPTimer()

        }
    }

    func startOTPTimer() {
        otpTimer = 60
        canResendOTP = false
        
        timerCancellable?.cancel()
        
        timerCancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                if self.otpTimer > 0 {
                    self.otpTimer -= 1
                } else {
                    self.canResendOTP = true
                    self.timerCancellable?.cancel()
                }
            }
    }

    func resendOTP() {
        sendOTP()
    }

    // MARK: - Department Functions

    func loadDepartments() {
        // MOCK data
        departments = [
            Department(id: "1", name: "Engineering"),
            Department(id: "2", name: "Human Resources"),
            Department(id: "3", name: "Marketing"),
            Department(id: "4", name: "Sales"),
            Department(id: "5", name: "Finance")
        ]

    }

    func toggleDepartmentPicker() {
        isDepartmentExpanded.toggle()
    }

    func selectDepartment(_ department: Department) {
        selectedDepartment = department
        isDepartmentExpanded = false
    }

    // MARK: - Validation

    func validatePassword() -> Bool {
        guard password.count >= 8 else {
            errorMessage = "Password must be at least 8 characters"
            return false
        }
        
        guard password.contains(where: { $0.isUppercase }) else {
            errorMessage = "Password must contain an uppercase letter"
            return false
        }
        
        guard password.contains(where: { $0.isLowercase }) else {
            errorMessage = "Password must contain a lowercase letter"
            return false
        }
        
        guard password.contains(where: { $0.isNumber }) else {
            errorMessage = "Password must contain a number"
            return false
        }
        
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match"
            return false
        }
        
        return true
    }

    func validateAllFields() -> Bool {

        guard !firstName.isEmpty else {
            errorMessage = "First name is required"
            return false
        }
        
        guard !lastName.isEmpty else {
            errorMessage = "Last name is required"
            return false
        }
        
        guard !email.isEmpty else {
            errorMessage = "Email is required"
            return false
        }
        
        guard !phoneNumber.isEmpty else {
            errorMessage = "Phone number is required"
            return false
        }
        
        guard !otpCode.isEmpty else {
            errorMessage = "OTP code is required"
            return false
        }
        
        guard selectedDepartment != nil else {
            errorMessage = "Please select a department"
            return false
        }
        
        guard validatePassword() else {
            return false
        }
        
        guard agreedToTerms else {
            errorMessage = "Please agree to terms and conditions"
            return false
        }
        
        return true
    }

    // MARK: - Create Account

    func createAccount(authCoordinator: AuthCoordinator) {

        guard validateAllFields() else {
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        // MOCK: Simulate account creation
        Task {
            try? await Task.sleep(nanoseconds: 2_000_000_000)  // 2 seconds
            keychainManager.saveToken("mock_token_new_user")
            
            isLoading = false
            
            authCoordinator.didAuthenticate()
            
            // let response = try await createAccountUseCase.execute(
            //     firstName: firstName,
            //     lastName: lastName,
            //     email: email,
            //     phoneNumber: phoneNumber,
            //     departmentId: selectedDepartment!.id,
            //     password: password
            // )
            // keychainManager.saveToken(response.token)
            // authCoordinator.didAuthenticate()
        }
    }
    
}


