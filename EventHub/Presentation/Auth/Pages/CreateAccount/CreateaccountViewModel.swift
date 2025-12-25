//
//  CreateaccountViewModel.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 21.12.25.
//

import SwiftUI
import Combine

@MainActor
final class CreateAccountViewModel: ObservableObject {
    
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
    
    @Published var firstNameError: String?
    @Published var lastNameError: String?
    @Published var emailError: String?
    @Published var phoneError: String?
    @Published var otpError: String?
    @Published var passwordError: String?
    @Published var confirmPasswordError: String?
    
    private var hasAttemptedSubmit = false
    
    // MARK: - Dependencies
    private let keychainManager = KeychainManager()
    private var timerCancellable: AnyCancellable?
    
    
    func validateFirstName() {
        guard hasAttemptedSubmit else { return }
        
        firstName = firstName.trimmingCharacters(in: .whitespaces)
        
        if firstName.isEmpty {
            firstNameError = "Required"
        } else if firstName.count < 2 {
            firstNameError = "Min 2 characters"
        } else if !firstName.allSatisfy({ $0.isLetter || $0.isWhitespace }) {
            firstNameError = "Letters only"
        } else {
            firstNameError = nil
        }
    }
    
    func validateLastName() {
        guard hasAttemptedSubmit else { return }
        
        lastName = lastName.trimmingCharacters(in: .whitespaces)
        
        if lastName.isEmpty {
            lastNameError = "Required"
        } else if lastName.count < 2 {
            lastNameError = "Min 2 characters"
        } else if !lastName.allSatisfy({ $0.isLetter || $0.isWhitespace }) {
            lastNameError = "Letters only"
        } else {
            lastNameError = nil
        }
    }
    
    func validateEmail() {
        guard hasAttemptedSubmit else { return }
        
        email = email.trimmingCharacters(in: .whitespaces).lowercased()
        
        if email.isEmpty {
            emailError = "Required"
        } else if !isValidEmail(email) {
            emailError = "Invalid email"
        } else {
            emailError = nil
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES[c] %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func validatePhoneNumber() {
        guard hasAttemptedSubmit else { return }  // ADDED
        
        phoneNumber = phoneNumber.filter { $0.isNumber || $0 == "+" }
        
        if phoneNumber.isEmpty {
            phoneError = "Required"
        } else if phoneNumber.count < 9 {
            phoneError = "Too short"
        } else if phoneNumber.count > 15 {
            phoneError = "Too long"
        } else {
            phoneError = nil
        }
    }
    
    func validateOTP() {
        guard hasAttemptedSubmit else { return }
        
        otpCode = otpCode.filter { $0.isNumber }
        
        if otpCode.isEmpty {
            otpError = "Required"
        } else if otpCode.count != 6 {
            otpError = "Must be 6 digits"
        } else {
            otpError = nil
        }
    }
    
    func validatePassword() {
        guard hasAttemptedSubmit else { return }
        
        if password.isEmpty {
            passwordError = "Required"
        } else if password.count < 8 {
            passwordError = "Min 8 characters"
        } else if !password.contains(where: { $0.isUppercase }) {
            passwordError = "Need uppercase"
        } else if !password.contains(where: { $0.isLowercase }) {
            passwordError = "Need lowercase"
        } else if !password.contains(where: { $0.isNumber }) {
            passwordError = "Need number"
        } else {
            passwordError = nil
        }
        
        if !confirmPassword.isEmpty {
            validateConfirmPassword()
        }
    }
    
    func validateConfirmPassword() {
        guard hasAttemptedSubmit else { return }
        
        if confirmPassword.isEmpty {
            confirmPasswordError = "Required"
        } else if confirmPassword != password {
            confirmPasswordError = "Doesn't match"
        } else {
            confirmPasswordError = nil
        }
    }
    
    private func validateAllFields() {
        hasAttemptedSubmit = true
        
        validateFirstName()
        validateLastName()
        validateEmail()
        validatePhoneNumber()
        validateOTP()
        validatePassword()
        validateConfirmPassword()
    }
    
    var isFormValid: Bool {
        return !firstName.isEmpty &&
               !lastName.isEmpty &&
               !email.isEmpty &&
               !phoneNumber.isEmpty &&
               !otpCode.isEmpty &&
               selectedDepartment != nil &&
               !password.isEmpty &&
               !confirmPassword.isEmpty &&
               agreedToTerms &&
               firstNameError == nil &&
               lastNameError == nil &&
               emailError == nil &&
               phoneError == nil &&
               otpError == nil &&
               passwordError == nil &&
               confirmPasswordError == nil
    }
    
    // MARK: - OTP Functions
    func sendOTP() {
        phoneNumber = phoneNumber.filter { $0.isNumber || $0 == "+" }
        
        guard !phoneNumber.isEmpty else {
            errorMessage = "Phone number is required"
            return
        }
        
        guard phoneNumber.count >= 9 else {
            errorMessage = "Phone number is too short"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        Task {
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            isLoading = false
            startOTPTimer()
            print("📱 OTP sent to: \(phoneNumber)")
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
    
    // MARK: - Create Account
    func createAccount(authCoordinator: AuthCoordinator) {
        validateAllFields()
        
        guard isFormValid else {
            errorMessage = "Please fill all fields correctly"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        Task {
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            
            keychainManager.saveToken("mock_token_new_user")
            
            let fullName = "\(firstName) \(lastName)"
            UserDefaults.standard.set(fullName, forKey: "userFullName")
            UserDefaults.standard.set(email, forKey: "userEmail")
            UserDefaults.standard.set(2, forKey: "userId")
            
            isLoading = false
            authCoordinator.didAuthenticate()
            
            print("✅ Account created: \(fullName)")
        }
    }
}
