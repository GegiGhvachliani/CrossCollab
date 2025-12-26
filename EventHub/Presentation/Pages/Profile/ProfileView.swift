//
//  ProfileView.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 21.12.25.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel: ProfileViewModel
    @EnvironmentObject var appCoordinator: AppCoordinator
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                
                // Profile Icon
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray)
                    .padding(.top, 40)
                
                // User Info
                VStack(spacing: 8) {
                    Text(viewModel.userName)
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    if !viewModel.userEmail.isEmpty {
                        Text(viewModel.userEmail)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                
                Spacer()
                
                // Logout Button
                Button(action: {
                    viewModel.logout()
                    appCoordinator.isAuthenticated = false
                })  {
                    HStack {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                        Text("Sign Out")
                    }
                    .font(.system(size: 16, weight: .semibold))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
                .padding(.horizontal)
                .padding(.bottom, 40)
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.loadUserData()
            }
        }
    }
}

#Preview {
    ProfileView(viewModel: DIContainer.shared.makeProfileViewModel())
        .environmentObject(AppCoordinator(keychainManager: KeychainManager()))
}
