//
//  CreateAccountView.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 21.12.25.
//

import SwiftUI

struct CreateAccountView: View {
    @EnvironmentObject var authCoordinator: AuthCoordinator
    
    @StateObject private var viewModel = CreateAccountViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                CustomHeaderView(
                    title: "Create Account",
                    subTitle: "Enter your details to get started"
                )
                
                FirstNameLastNameEmailPhoneNumberView(
                    firstName: $viewModel.firstName,
                    lastName: $viewModel.lastName,
                    email: $viewModel.email,
                    phoneNumber: $viewModel.phoneNumber,
                    firstNameError: viewModel.firstNameError,
                    lastNameError: viewModel.lastNameError,
                    emailError: viewModel.emailError,
                    phoneError: viewModel.phoneError,
                    onFirstNameChange: { viewModel.validateFirstName() },
                    onLastNameChange: { viewModel.validateLastName() },
                    onEmailChange: { viewModel.validateEmail() },
                    onPhoneChange: { viewModel.validatePhoneNumber() },
                    onSendOTP: { viewModel.sendOTP() }
                )
                
                OTPSectionView(
                    otpCode: $viewModel.otpCode,
                    otpTimer: viewModel.otpTimer,
                    canResendOTP: viewModel.canResendOTP,
                    otpError: viewModel.otpError,
                    onOTPChange: { viewModel.validateOTP() },
                    onResend: { viewModel.resendOTP() }
                )
                
                DepartmentSelectionView(
                    departments: viewModel.departments,
                    selectedDepartment: viewModel.selectedDepartment,
                    isExpanded: $viewModel.isDepartmentExpanded,
                    onToggle: { viewModel.toggleDepartmentPicker() },
                    onSelect: { department in viewModel.selectDepartment(department) }
                )
                
                PasswordView(
                    password: $viewModel.password,
                    confirmPassword: $viewModel.confirmPassword,
                    passwordError: viewModel.passwordError,
                    confirmPasswordError: viewModel.confirmPasswordError,
                    onPasswordChange: { viewModel.validatePassword() },
                    onConfirmPasswordChange: { viewModel.validateConfirmPassword() }
                )
                
                AgreementCheckmark(
                    isAgreementMarked: $viewModel.agreedToTerms
                )
                
                CreateAccountButtonView(
                    isLoading: viewModel.isLoading,
                    onCreate: {
                        viewModel.createAccount(authCoordinator: authCoordinator)
                    },
                    onSignIn: {
                        authCoordinator.navigateToSignIn()
                    }
                )
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.system(size: 14))
                        .padding(.horizontal, 30)
                }
            }
            .padding(.vertical, 20)
        }
        .onAppear {
            viewModel.loadDepartments()
        }
    }
}

#Preview {
    CreateAccountView()
        .environmentObject(AuthCoordinator())
}

// MARK: - First Name, Last Name, Email, Phone Number View
struct FirstNameLastNameEmailPhoneNumberView: View {
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var email: String
    @Binding var phoneNumber: String
    
    let firstNameError: String?
    let lastNameError: String?
    let emailError: String?
    let phoneError: String?
    
    let onFirstNameChange: () -> Void
    let onLastNameChange: () -> Void
    let onEmailChange: () -> Void
    let onPhoneChange: () -> Void
    let onSendOTP: () -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 3) {
                    CustomTextField(
                        text: $firstName,
                        title: "First Name",
                        placeHolder: "John"
                    )
                    .onChange(of: firstName) { _ in onFirstNameChange() }
                    
                    Text(firstNameError ?? " ")
                        .font(.system(size: 11))
                        .foregroundColor(.red)
                        .frame(height: 14)
                }
                
                VStack(alignment: .leading, spacing: 3) {
                    CustomTextField(
                        text: $lastName,
                        title: "Last Name",
                        placeHolder: "Doe"
                    )
                    .onChange(of: lastName) { _ in onLastNameChange() }
                    
                    Text(lastNameError ?? " ")
                        .font(.system(size: 11))
                        .foregroundColor(.red)
                        .frame(height: 14)
                }
            }
            
            VStack(alignment: .leading, spacing: 3) {
                CustomTextField(
                    text: $email,
                    title: "Email",
                    placeHolder: "john.doe@company.com"
                )
                .onChange(of: email) { _ in onEmailChange() }
                
                Text(emailError ?? " ")
                    .font(.system(size: 11))
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 14)
            }
            
            VStack(alignment: .leading, spacing: 3) {
                HStack(spacing: 10) {
                    CustomTextField(
                        text: $phoneNumber,
                        title: "Phone Number",
                        placeHolder: "+995 555 123456"
                    )
                    .onChange(of: phoneNumber) { _ in onPhoneChange() }
                    
                    Button {
                        onSendOTP()
                    } label: {
                        Text("Send OTP")
                            .foregroundStyle(.black)
                            .font(.system(size: 14))
                            .padding(.horizontal, 20)
                            .padding(.vertical, 12)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 2)
                            )
                            .background(Color.secondary.opacity(0.2))
                            .cornerRadius(7)
                            .offset(y: 13)
                    }
                }
                
                Text(phoneError ?? " ")
                    .font(.system(size: 11))
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 14)
            }
        }
        .padding(.horizontal, 30)
    }
}

// MARK: - OTP Section View
struct OTPSectionView: View {
    @Binding var otpCode: String
    
    let otpTimer: Int
    let canResendOTP: Bool
    let otpError: String?
    let onOTPChange: () -> Void
    let onResend: () -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Image(systemName: "shield.lefthalf.filled")
                Text("Enter OTP Code")
                Spacer()
            }
            .font(.system(size: 15))
            .padding(.horizontal, 30)
            
            OTPView(otp: $otpCode)
                .onChange(of: otpCode) { _ in onOTPChange() }
            
            Text(otpError ?? " ")
                .font(.system(size: 11))
                .foregroundColor(.red)
                .padding(.horizontal, 30)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 14)
            
            HStack {
                if otpTimer > 0 {
                    Text("code expires in \(otpTimer)s")
                        .foregroundColor(.black.opacity(0.6))
                        .font(.system(size: 14))
                }
                
                Spacer()
                
                Button {
                    onResend()
                } label: {
                    Text("Resend Code")
                        .font(.system(size: 15))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .disabled(!canResendOTP)
            }
            .offset(y: -10)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 40)
        }
    }
}

// MARK: - Department Selection View
struct DepartmentSelectionView: View {
    let departments: [Department]
    let selectedDepartment: Department?
    @Binding var isExpanded: Bool
    
    let onToggle: () -> Void
    let onSelect: (Department) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Department")
                .font(.system(size: 15))
                .padding(.horizontal, 30)
            
            Button {
                onToggle()
            } label: {
                HStack {
                    Text(selectedDepartment?.name ?? "Select Department")
                        .foregroundColor(selectedDepartment == nil ? .gray : .primary)
                    
                    Spacer()
                    
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.gray)
                }
                .font(.system(size: 15))
                .padding(15)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                )
            }
            .padding(.horizontal, 30)
            
            if isExpanded {
                VStack(spacing: 0) {
                    ForEach(departments) { department in
                        Button {
                            onSelect(department)
                        } label: {
                            HStack {
                                Text(department.name)
                                    .foregroundColor(.primary)
                                
                                Spacer()
                                
                                if selectedDepartment?.id == department.id {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.blue)
                                }
                            }
                            .padding(.vertical, 12)
                            .padding(.horizontal, 15)
                        }
                        
                        if department.id != departments.last?.id {
                            Divider()
                        }
                    }
                }
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding(.horizontal, 30)
            }
        }
    }
}

// MARK: - Password View
struct PasswordView: View {
    @Binding var password: String
    @Binding var confirmPassword: String
    
    let passwordError: String?
    let confirmPasswordError: String?
    let onPasswordChange: () -> Void
    let onConfirmPasswordChange: () -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 3) {
                CustomPasswordTextField(
                    text: $password,
                    title: "Password",
                    placeHolder: "Create password"
                )
                .onChange(of: password) { _ in onPasswordChange() }
                
                if let error = passwordError {
                    Text(error)
                        .font(.system(size: 11))
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: 28)
                } else {
                    Text("Min 8 chars with uppercase, lowercase, number")
                        .foregroundStyle(.black.opacity(0.6))
                        .font(.system(size: 11))
                        .lineLimit(2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: 28)
                }
            }
            
            VStack(alignment: .leading, spacing: 3) {
                CustomPasswordTextField(
                    text: $confirmPassword,
                    title: "Confirm Password",
                    placeHolder: "Confirm password"
                )
                .onChange(of: confirmPassword) { _ in onConfirmPasswordChange() }
                
                Text(confirmPasswordError ?? " ")
                    .font(.system(size: 11))
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 14)
            }
        }
        .padding(.horizontal, 30)
    }
}

// MARK: - Agreement Checkmark
struct AgreementCheckmark: View {
    @Binding var isAgreementMarked: Bool
    
    var body: some View {
        HStack(alignment: .top) {
            Button {
                isAgreementMarked.toggle()
            } label: {
                Image(systemName: isAgreementMarked ? "checkmark.square" : "square")
                    .foregroundColor(.gray)
                    .font(.system(size: 20))
            }
            
            Text("I agree to the Terms of Service and Privacy Policy")
                .offset(y: -5)
                .font(.system(size: 15))
                .lineLimit(2)
            
            Spacer()
        }
        .padding(.horizontal, 30)
    }
}

// MARK: - Create Account Button View
struct CreateAccountButtonView: View {
    let isLoading: Bool
    let onCreate: () -> Void
    let onSignIn: () -> Void
    
    var body: some View {
        VStack(spacing: 15) {
            CustomButton(
                title: "Create Account",
                action: onCreate,
                isLoading: isLoading
            )
            
            HStack {
                Text("Already have an account?")
                    .font(.system(size: 15))
                
                Button {
                    onSignIn()
                } label: {
                    Text("Sign In")
                        .font(.system(size: 15))
                }
            }
        }
        .padding(.horizontal, 30)
    }
}
