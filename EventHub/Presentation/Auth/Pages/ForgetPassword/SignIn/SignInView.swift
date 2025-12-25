//
//  SignInView.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 21.12.25.
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject var authCoordinator: AuthCoordinator
    @StateObject private var viewModel = SignInViewModel()
    
    var body: some View {
        VStack(spacing: 10) {
            CustomHeaderView(title: "Sign In", subTitle: "Enter your credentials to accsess your account")
            
            InputView(
                emailText: $viewModel.email,
                passwordText: $viewModel.password
            )
            
            RememberMeAndForgotPasswordView(
                isRememberMeCheckmarked: $viewModel.rememberMe
            )
            
            SignInAndSignUpView(
                isLoading: viewModel.isLoading,
                onSignIn: {
                    viewModel.signIn(authCoordinator: authCoordinator)
                }
            )
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.red)
                    .font(.system(size: 14))
                    .padding(.horizontal)
            } else {
                Text("")
                    .font(.system(size: 14))
            }
        }
        .onAppear {
            viewModel.loadRememberMe()
             viewModel.testNetworkLayer()
        }
    }
}

#Preview {
    SignInView()
        .environmentObject(AuthCoordinator())
}


struct InputView: View {
    @Binding var emailText: String
    @Binding var passwordText: String
    var body: some View {
        VStack(spacing: 25) {
            CustomTextField(text: $emailText,
                            title: "Email",
                            placeHolder: "Enter your Email"
            )
            
            CustomPasswordTextField(text: $passwordText,
                                    title: "Password",
                                    placeHolder: "Enter your Password"
            )
        }
        .padding(.horizontal, 30)
        .padding(.top, 35)
    }
}

struct RememberMeAndForgotPasswordView: View {
    @EnvironmentObject var authCoordinator: AuthCoordinator
    @Binding var isRememberMeCheckmarked: Bool
    var body: some View {
        HStack() {
            Button {
                isRememberMeCheckmarked.toggle()
            } label: {
                HStack{
                    Image(systemName: isRememberMeCheckmarked ? "checkmark.square" : "square")
                        .foregroundColor(.gray)
                        .font(.system(size: 20)
                        )
                    
                    Text("Remember me")
                        .font(.system(size: 15))
                }
            }
            
            Spacer()
            
            Button {
                authCoordinator.navigateToForgotPassword()
            } label: {
                Text("Forgot password?")
                    .font(.system(size: 15))
            }
        }
        .padding(.horizontal, 30)
    }
}

struct SignInAndSignUpView: View {
    @EnvironmentObject var authCoordinator: AuthCoordinator
    
    let isLoading: Bool
    let onSignIn: () -> Void
    var body: some View {
        VStack(spacing: 20) {
            CustomButton(
                title: "Sign In",
                action: onSignIn,
                isLoading: isLoading
            )
            HStack {
                Text("Don't have an account?")
                    .font(.system(size: 15))
                Button {
                    authCoordinator.navigateToRegister()
                } label: {
                    Text("Sign Up")
                        .font(.system(size: 15))
                }
                
            }
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 40)
    }
}
