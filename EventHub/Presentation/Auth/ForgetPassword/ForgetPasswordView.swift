//
//  ForgotPasswordView.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 21.12.25.
//

import SwiftUI

struct ForgotPasswordView: View {
    @EnvironmentObject var authCoordinator: AuthCoordinator
    
    @StateObject private var viewModel = ForgotPasswordViewModel()
    
    var body: some View {
        VStack(spacing: 40) {
            CustomHeaderView(
                title: "Forgot Password",
                subTitle: "Enter your email and we'll send you a link to reset your password."
            )
            .padding(.bottom, 10)
            
            CustomTextField(
                text: $viewModel.email,
                title: "Email",
                placeHolder: "Enter your email",
                withSymbol: true
            )
            .padding(.horizontal, 30)
            
            CustomButton(
                title: "Send Reset Link",
                action: {
                    viewModel.sendResetLink()
                },
                isLoading: viewModel.isLoading
            )
            .padding(.horizontal, 30)
            
            Button {
                authCoordinator.navigateToSignIn()
            } label: {
                HStack {
                    Image(systemName: "arrow.left")
                    Text("Back to Sign In")
                }
                .offset(y: -20)
            }
            
            ZStack {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.system(size: 14))
                        .padding(.horizontal, 30)
                } else {
                    Text("")
                }
                
                if let successMessage = viewModel.successMessage {
                    Text(successMessage)
                        .foregroundColor(.green)
                        .font(.system(size: 14))
                        .padding(.horizontal, 30)
                        .multilineTextAlignment(.center)
                } else {
                    Text("")
                }
            }
            
            
            
        }
    }
}

#Preview {
    ForgotPasswordView()
        .environmentObject(AuthCoordinator())
}
