//
//  AuthCoordinatorView.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 22.12.25.
//

import SwiftUI

struct AuthCoordinatorView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    
    // Create AuthCoordinator for navigation
    @StateObject private var authCoordinator = AuthCoordinator()
    
    var body: some View {
        // NavigationStack with path from AuthCoordinator
        NavigationStack(path: $authCoordinator.path) {
            // Root screen = SignIn
            SignInView()
                // Define destinations for navigation
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
        .environmentObject(authCoordinator)  // Make authCoordinator available to all auth views
        .onAppear {
            // Give authCoordinator access to appCoordinator
            authCoordinator.setAppCoordinator(appCoordinator)
        }
    }
}

#Preview {
    AuthCoordinatorView()
        .environmentObject(AppCoordinator(keychainManager: KeychainManager()))
}
