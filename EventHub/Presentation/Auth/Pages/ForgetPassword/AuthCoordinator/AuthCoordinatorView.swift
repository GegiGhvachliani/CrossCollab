//
//  AuthCoordinatorView.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 22.12.25.
//

import SwiftUI

struct AuthCoordinatorView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    
    @StateObject private var authCoordinator = AuthCoordinator()
    
    var body: some View {
        NavigationStack(path: $authCoordinator.path) {
            SignInView()
                .navigationDestination(for: AuthRoute.self) { route in
                    switch route {
                    case .signIn:
                        SignInView()
                    case .register:
                        CreateAccountView()
                    case .forgotPassword:
                        ForgotPasswordView()
                    }
                }
        }
        .environmentObject(authCoordinator)
        .onAppear {
            authCoordinator.setAppCoordinator(appCoordinator)
        }
    }
}

#Preview {
    AuthCoordinatorView()
        .environmentObject(AppCoordinator(keychainManager: KeychainManager()))
}
