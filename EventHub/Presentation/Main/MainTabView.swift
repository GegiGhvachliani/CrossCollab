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
            
            BrowseView()
                .tabItem {
                    Label("Browse", systemImage: "magnifyingglass")
                }
            
            MyEventsView()
                .tabItem {
                    Label("My Events", systemImage: "calendar")
                }
            
            UpdatesView()
                .tabItem {
                    Label("Updates", systemImage: "bell.fill")
                }
            
            ProfileView()
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
