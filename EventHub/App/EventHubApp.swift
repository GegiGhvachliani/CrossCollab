//
//  EventHubApp.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 20.12.25.
//

import SwiftUI

@main
struct EventHubApp: App {
    
    @StateObject private var appCoordinator: AppCoordinator
    
    init() {
        let keychainManager = KeychainManager()
        _appCoordinator = StateObject(wrappedValue: AppCoordinator(keychainManager: keychainManager))
    }
    
    var body: some Scene {
        WindowGroup {
            if appCoordinator.isAuthenticated {
                MainTabView()
                    .environmentObject(appCoordinator)
            } else {
                AuthCoordinatorView()
                    .environmentObject(appCoordinator)
            }
        }
    }
}
