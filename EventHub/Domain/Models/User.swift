//
//  User.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 21.12.25.
//

import Foundation

// MARK: - User Model (Domain)
struct User: Identifiable, Codable {
    let id: Int
    let fullName: String
    let email: String
    let role: String
}

// MARK: - Auth Response (from backend)
struct AuthResponse: Codable {
    let token: String
    let userId: Int
    let fullName: String
    let role: String
    let expiresAt: String
    
    func toUser() -> User {
        return User(
            id: userId,
            fullName: fullName,
            email: "",
            role: role
        )
    }
}
