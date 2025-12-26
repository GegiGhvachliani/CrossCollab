//
//  ProfileViewModel.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 21.12.25.
//


import SwiftUI
import Combine

@MainActor
final class ProfileViewModel: ObservableObject {
    
    @Published var userName: String = "User"
    @Published var userEmail: String = ""
    
    private let keychainManager: KeychainManager
    
    init(keychainManager: KeychainManager) {
        self.keychainManager = keychainManager
        loadUserData()
    }
    
    func loadUserData() {
        userName = UserDefaults.standard.string(forKey: "userFullName") ?? "User"
        userEmail = UserDefaults.standard.string(forKey: "userEmail") ?? ""
    }
    
    func logout() {
        // Clear token
        keychainManager.deleteToken()
        
        // Clear user data
        UserDefaults.standard.removeObject(forKey: "userFullName")
        UserDefaults.standard.removeObject(forKey: "userId")
        UserDefaults.standard.removeObject(forKey: "userEmail")
        
        print("🔴 User logged out")
    }
}
