//
//  KeychainManager.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 21.12.25.
//

import Foundation

final class KeychainManager {
    
    func saveToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: "authToken")
    }
    
    func getToken() -> String? {
        UserDefaults.standard.string(forKey: "authToken")
    }
    
    func deleteToken() {
        UserDefaults.standard.removeObject(forKey: "authToken")
    }
}
