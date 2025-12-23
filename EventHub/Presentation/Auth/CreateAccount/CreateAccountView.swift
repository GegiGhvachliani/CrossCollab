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
                    onSendOTP: {
                        viewModel.sendOTP()
                    }
                )
                
                OTPSectionView(
                    otpCode: $viewModel.otpCode,
                    otpTimer: viewModel.otpTimer,
                    canResendOTP: viewModel.canResendOTP,
                    onResend: {
                        viewModel.resendOTP()
                    }
                )
                
                DepartmentSelectionView(
                    departments: viewModel.departments,
                    selectedDepartment: viewModel.selectedDepartment,
                    isExpanded: $viewModel.isDepartmentExpanded,
                    onToggle: {
                        viewModel.toggleDepartmentPicker()
                    },
                    onSelect: { department in
                        viewModel.selectDepartment(department)
                    }
                )
                
                PasswordView(
                    password: $viewModel.password,
                    confirmPassword: $viewModel.confirmPassword
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

struct FirstNameLastNameEmailPhoneNumberView: View {
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var email: String
    @Binding var phoneNumber: String
    
    let onSendOTP: () -> Void
    
    var body: some View {
        VStack(spacing: 15) {
            HStack(spacing: 15) {
                CustomTextField(
                    text: $firstName,
                    title: "First Name",
                    placeHolder: "John"
                )
                
                CustomTextField(
                    text: $lastName,
                    title: "Last Name",
                    placeHolder: "Doe"
                )
            }
            
            CustomTextField(
                text: $email,
                title: "Email",
                placeHolder: "john.doe@company.com"
            )
            
            HStack(spacing: 10) {
                CustomTextField(
                    text: $phoneNumber,
                    title: "Phone Number",
                    placeHolder: "+1 (000) 000-000"
                )
                
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
        }
        .padding(.horizontal, 30)
    }
}

struct OTPSectionView: View {
    @Binding var otpCode: String
    
    let otpTimer: Int
    let canResendOTP: Bool
    let onResend: () -> Void
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Image(systemName: "shield.lefthalf.filled")
                
                Text("Enter OTP Code")
                
                Spacer()
                
            }
            .font(.system(size: 15))
            .padding(.horizontal, 30)
            
            OTPView(otp: $otpCode)
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

struct PasswordView: View {
    @Binding var password: String
    @Binding var confirmPassword: String
    
    var body: some View {
        VStack(spacing: 15) {
            VStack(spacing: 5) {
                CustomPasswordTextField(
                    text: $password,
                    title: "Password",
                    placeHolder: "Create password"
                )
                
                Text("Password must be at least 8 characters with uppercase, lowercase and number.")
                    .foregroundStyle(.black.opacity(0.6))
                    .font(.system(size: 12))
                    .lineLimit(2)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            CustomPasswordTextField(  // CHANGED: Use secure field
                text: $confirmPassword,
                title: "Confirm Password",
                placeHolder: "Confirm password"
            )
        }
        .padding(.horizontal, 30)
    }
}

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
