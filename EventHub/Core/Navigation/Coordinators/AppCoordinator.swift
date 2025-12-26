//
//  Untitled.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 21.12.25.
//

import SwiftUI
import Combine

@MainActor
final class AppCoordinator: ObservableObject {
    @Published var isAuthenticated = false
    
    private let keychainManager: KeychainManager
    
    init(keychainManager: KeychainManager) {
        self.keychainManager = keychainManager
        checkAuthStatus()
    }
    
    func checkAuthStatus() {
        if let token = keychainManager.getToken(), !token.isEmpty {
            isAuthenticated = true
        } else {
            isAuthenticated = false
        }
    }
    
    
    func signOut() {
        keychainManager.deleteToken()
        isAuthenticated = false
    }
}
