//
//
//  Untitled.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 21.12.25.
//

import SwiftUI
import Combine

@MainActor
class AuthCoordinator: ObservableObject {
    
    @Published var path = NavigationPath()
    
    private weak var appCoordinator: AppCoordinator?
    
    func setAppCoordinator(_ coordinator: AppCoordinator) {
        self.appCoordinator = coordinator
    }
    
    func didAuthenticate() {
        appCoordinator?.isAuthenticated = true
    }
    
    func navigateToRegister() {
        path.append(AuthRoute.register)
    }
    
    func navigateToForgotPassword() {
        path.append(AuthRoute.forgotPassword)
    }
    
    func navigateToSignIn() {
        path.removeLast(path.count)
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    

}
