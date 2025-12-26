//
//  MainTabView.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 21.12.25.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    
    var body: some View {
        TabView {
            HomeView(viewModel: DIContainer.shared.makeHomeViewModel())
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            BrowseView(viewModel: DIContainer.shared.makeBrowseViewModel())
                .tabItem {
                    Label("Browse", systemImage: "magnifyingglass")
                }
            
            MyEventsView(viewModel: DIContainer.shared.makeMyEventsViewModel())
                .tabItem {
                    Label("My Events", systemImage: "calendar")
                }
            
            NotificationsView(viewModel: DIContainer.shared.makeNotificationsViewModel())
                .tabItem {
                    Label("Notifications", systemImage: "bell.fill")
                }
            
            ProfileView(viewModel: DIContainer.shared.makeProfileViewModel())
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
        .environmentObject(appCoordinator)
    }
}

#Preview {
    MainTabView()
        .environmentObject(AppCoordinator(keychainManager: KeychainManager()))
}
