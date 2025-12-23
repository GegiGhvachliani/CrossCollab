//
//  ProfileView.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 21.12.25.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Text("Profile Screen")
                    .font(.largeTitle)
                    .bold()
                
                Text("User profile info will be here")
                    .foregroundColor(.gray)
                
                Spacer()
                
                // Sign Out button
                CustomButton(
                    title: "Sign Out",
                    action: {
                        appCoordinator.signOut()
                    },
                    isLoading: false,
                    backgroundColor: .red
                )
                .padding(.horizontal, 30)
                .padding(.bottom, 50)
            }
            .navigationTitle("Profile")
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(AppCoordinator(keychainManager: KeychainManager()))
}
