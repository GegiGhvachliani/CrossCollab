//
//  NetworkService.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 21.12.25.
//

import Foundation

class NetworkService: NetworkServiceProtocol {
    
    private let keychainManager: KeychainManager
    
    private let useMockData = false
    
    init(keychainManager: KeychainManager) {
        self.keychainManager = keychainManager
    }
    
    // MARK: - Request with Response
    func request<T: Codable>(
        endpoint: APIEndpoint,
        responseType: T.Type
    ) async throws -> T {
        
        if useMockData {
            return try await mockResponse(for: endpoint, responseType: responseType)
        }
        
        guard let url = endpoint.buildURL() else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let token = keychainManager.getToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unknown
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            break
        case 401:
            throw NetworkError.unauthorized
        case 400...599:
            throw NetworkError.serverError(httpResponse.statusCode)
        default:
            throw NetworkError.unknown
        }
        
        guard !data.isEmpty else {
            throw NetworkError.noData
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            print("❌ Decoding error: \(error)")
            if let json = String(data: data, encoding: .utf8) {
                print("📦 Response JSON: \(json)")
            }
            throw NetworkError.decodingError
        }
    }
    
    // MARK: - Request without Response
    func requestWithoutResponse(
        endpoint: APIEndpoint
    ) async throws {
        
        if useMockData {
            try await mockRequestWithoutResponse(for: endpoint)
            return
        }
        
        guard let url = endpoint.buildURL() else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let token = keychainManager.getToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unknown
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            return
        case 401:
            throw NetworkError.unauthorized
        case 400...599:
            throw NetworkError.serverError(httpResponse.statusCode)
        default:
            throw NetworkError.unknown
        }
    }
}

// MARK: - Mock Data
extension NetworkService {
    
    private func mockResponse<T: Codable>(
        for endpoint: APIEndpoint,
        responseType: T.Type
    ) async throws -> T {
        
        try await Task.sleep(nanoseconds: 500_000_000)
        
        switch endpoint {
            
        case .login:
            let response = AuthResponse(
                token: "mock_token_12345",
                userId: 1,
                fullName: "Gegi Ghvachliani",
                role: "Employee",
                expiresAt: "2025-12-31T23:59:59Z"
            )
            return response as! T
            
        case .getEvents:
            let events = MockData.events
            return events as! T
            
        case .getEventDetail(let id):
            if let event = MockData.events.first(where: { $0.id == id }) {
                return event as! T
            }
            throw NetworkError.noData
            
        case .registerForEvent(let eventId):
            let registration = Registration(
                registrationId: Int.random(in: 1000...9999),
                eventId: eventId,
                eventTitle: "Mock Event Title",
                eventType: "Workshop",
                startDateTime: "2025-12-28T10:00:00Z",
                location: "TBC Academy",
                status: eventId == 102 ? "Waitlisted" : "Confirmed",
                registeredAt: ISO8601DateFormatter().string(from: Date()),
                eventIsActive: true,
                eventMessage: nil
            )
            return registration as! T
            
        case .getMyRegistrations:
            let registrations = MockData.myRegistrations
            return registrations as! T
            
        case .getNotifications:
            let notifications = MockData.notifications
            return notifications as! T
            
        default:
            throw NetworkError.unknown
        }
    }
    
    private func mockRequestWithoutResponse(for endpoint: APIEndpoint) async throws {
        try await Task.sleep(nanoseconds: 500_000_000)
        
        switch endpoint {
        case .cancelRegistration:
            print("✅ Mock: Registration cancelled")
            return
        default:
            return
        }
    }
}
